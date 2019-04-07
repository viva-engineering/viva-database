
create database viva;

use viva;

-- Reference table containing all possible privacy setting combinations
-- Each user will reference one of these setting combinations
-- (2 ** 4) * (3 ** 6) = 11664 records
create table user_privacy_settings (
  id int unsigned primary key not null auto_increment,

  -- Discoverability values: control how a user can be found by other users
  --  0 = Private, not discoverable by this value
  --  1 = Public, user can be discovered by searching for this value
  discoverable_by_email tinyint(1) not null,
  discoverable_by_phone tinyint(1) not null,
  discoverable_by_name tinyint(1) not null,
  discoverable_by_friend_code tinyint(1) not null,

  -- Privacy values: control what a user can see once they view the user's profile
  --  0 = Private, visible only to the user
  --  1 = Friends, visible only to the user and their friends
  --  2 = Public, visible to anyone who can see their profile
  email_privacy tinyint(1) not null,
  phone_privacy tinyint(1) not null,
  location_privacy tinyint(1) not null,
  birthday_privacy tinyint(1) not null,
  default_post_privacy tinyint(1) not null,
  default_image_privacy tinyint(1) not null,

  -- Record metadata
  created_timestamp timestamp not null default now(),
  updated_timestamp timestamp not null default now() on update now(),

  -- Index including all values, used when looking up a privacy profile to assign to a user
  unique key idx_user_privacy_settings_full (
    discoverable_by_email, discoverable_by_phone, discoverable_by_name, discoverable_by_friend_code,
    email_privacy, phone_privacy, location_privacy, birthday_privacy,
    default_post_privacy, default_image_privacy
  )
)
engine=InnoDB,
charset=utf8mb4;



-- 
-- Primary user table
-- Contains all users in the system and their basic user data
-- 

create table users (
  id bigint unsigned not null auto_increment,
  email varchar(255) not null,  -- TODO: Determine what size this really needs to be
  name varchar(255) not null default '',

  -- Additional info we might want to allow users to set on their own
  phone varchar(255) default null,
  location varchar(255) default null,
  birthday date default null,

  -- User's uniquely generated friend code
  friend_code varchar(255) unique not null,

  -- Status fields
  active tinyint(1) not null default 1,
  email_validated tinyint(1) not null default 0,

  -- Explicit content flags
  contains_explicit_content tinyint(1) not null default 0,
  explicit_content_visible tinyint(1) not null default 0,

  -- Elevated permissions flags
  is_admin tinyint(1) not null default 0,
  is_moderator tinyint(1) not null default 0,

  -- User's privacy settings configuration
  privacy_settings_id int unsigned not null,

  -- Record metadata
  created_timestamp timestamp not null default now(),
  updated_timestamp timestamp not null default now() on update now(),

  -- Keys/Indexes
  primary key (id),
  index idx_users_email (email),
  index idx_users_name (name),
  index idx_users_friend_code (friend_code),

  -- Foreign Keys
  constraint fk_user_privacy_settings_id
    foreign key (privacy_settings_id) references user_privacy_settings (id)
)
engine=InnoDB,
charset=utf8mb4;





-- 
-- Applications table
-- Contains any 3rd party applications with permission to create sessions on behalf of users
-- 

create table applications (
  id int unsigned not null auto_increment,
  name varchar(255) not null,
  secret_key_digest varchar(255) not null,
  owner_user_id bigint unsigned not null,
  active tinyint(1) not null default 1,
  approved tinyint(1) not null default 0,

  -- Record metadata
  created_timestamp timestamp not null default now(),
  updated_timestamp timestamp not null default now() on update now(),

  -- Keys/Indexes
  primary key (id),
  index idx_applications_owner_user_id (owner_user_id),

  -- Foreign Keys
  constraint fk_applications_owner_user_id
    foreign key (owner_user_id) references users (id)
)
engine=InnoDB,
charset=utf8mb4;





-- 
-- Sessions table
-- Contains any active user sessions
-- 

create table sessions (
  id varchar(255) not null,
  user_id bigint unsigned not null,
  expiration timestamp not null,

  -- If this session was created by an application on behalf of the user, keep track of
  -- which application created the session
  application_id int unsigned default null,

  -- Record metadata
  created_timestamp timestamp not null default now(),
  updated_timestamp timestamp not null default now() on update now(),

  -- Keys/Indexes
  primary key (id),
  index idx_sessions_user_id (user_id),

  -- Foreign Keys
  constraint fk_sessions_user_id
    foreign key (user_id) references users (id),
  constraint fk_sessions_application_id
    foreign key (application_id) references applications (id)
)
engine=InnoDB,
charset=utf8mb4;





-- 
-- Friends table
-- Contains associations between a user and their friends
-- 

create table friends (
  user_id_a bigint unsigned not null,
  user_id_b bigint unsigned not null,

  -- Record metadata
  created_timestamp timestamp not null default now(),
  updated_timestamp timestamp not null default now() on update now(),

  -- Keys/Indexes
  primary key (user_id_a, user_id_b),
  index idx_friends_user_id_b (user_id_b),

  -- Foreign Keys
  constraint fk_friends_user_id_a
    foreign key (user_id_a) references users (id),
  constraint fk_friends_user_id_b
    foreign key (user_id_b) references users (id)
)
engine=InnoDB,
charset=utf8mb4;





--
-- This table stores the top-level authentication data for each user.
-- This includes the password hash digest, various status fields, and
-- the password expiration timestamp
--

create table credentials (
  user_id bigint unsigned not null,

  -- Stores the password hash digest
  password_digest varchar(255) not null,

  -- This controls whether the credentials are active
  --   0: Credentials are not active and cannot be used to authenticate
  --   1: Credentials are active
  is_active tinyint(1) unsigned not null default 1,

  -- This marks a credentials record as potentially compromised, and is intended to be
  -- used in the case of a data theft or otherwise compromised account. It will lock the
  -- credentials, preventing authentication without a second auth factor until the credentials
  -- are updated
  --   0: Credentials are not considered compromised
  --   1: Credentials are considered compromised and additional security measures are required
  is_compromised tinyint(1) unsigned not null default 0,

  -- This controls if and when a security question is required for authentication
  --   0: No security question required
  --   1: Security question required for next authenticate
  --   2: Security question is always required
  require_security_question tinyint(1) unsigned not null default 0,

  -- This controls if and when a second auth factor is required for authentication
  --   0: No multi-factor auth is required
  --   1: Multi-factor auth required for next authenticate
  --   2: Multi-factor auth is always required
  require_multi_factor tinyint(1) unsigned not null default 0,

  -- Sets the expiration time for the current password. If passed, a new password will have to
  -- be set the next time the user authenticates
  password_expiration timestamp not null,

  -- Record metadata
  created_timestamp timestamp not null default now(),
  updated_timestamp timestamp not null default now() on update now(),

  -- Keys/Indexes
  primary key (user_id)
)
engine=InnoDB,
charset=utf8mb4;





-- 
-- Pages table
-- This table stores pages
-- 

create table pages (
  id int unsigned not null auto_increment,
  owner_user_id bigint unsigned not null,

  -- Record metadata
  created_timestamp timestamp not null default now(),
  updated_timestamp timestamp not null default now() on update now(),

  -- Keys/Indexes
  primary key (id),

  -- Foreign Keys
  constraint fk_pages_owner_user_id
    foreign key (owner_user_id) references users (id)
)
engine=InnoDB,
charset=utf8mb4;





-- 
-- Posts table
-- This table stores top-level posts made by users
-- 

create table posts (
  id bigint unsigned not null auto_increment,
  user_id bigint unsigned not null,
  page_id int unsigned,

  content text,

  -- Record metadata
  created_timestamp timestamp not null default now(),
  updated_timestamp timestamp not null default now() on update now(),

  -- Keys/Indexes
  primary key (id),
  index idx_posts_user_id (user_id),
  index idx_posts_page_id (page_id),

  -- Foreign Keys
  constraint fk_posts_user_id
    foreign key (user_id) references users (id),
  constraint fk_posts_page_id
    foreign key (page_id) references pages (id)
)
engine=InnoDB,
charset=utf8mb4;





-- 
-- Post comments table
-- This table stores comments made on posts
-- 

create table post_comments (
  id bigint unsigned not null auto_increment,
  user_id bigint unsigned not null,
  post_id bigint unsigned not null,

  -- TODO: Fill in comment contents columns

  -- Record metadata
  created_timestamp timestamp not null default now(),
  updated_timestamp timestamp not null default now() on update now(),

  -- Keys/Indexes
  primary key (id),
  index idx_post_comments_user_id (user_id),

  -- Foreign Keys
  constraint fk_post_comments_user_id
    foreign key (user_id) references users (id),
  constraint fk_post_comments_post_id
    foreign key (post_id) references posts (id)
)
engine=InnoDB,
charset=utf8mb4;



-- 
-- Generates all the possible combinations of privacy settings to populate the table
-- 

insert into user_privacy_settings
(
  discoverable_by_email,
  discoverable_by_phone,
  discoverable_by_name,
  discoverable_by_friend_code,
  email_privacy,
  phone_privacy,
  location_privacy,
  birthday_privacy,
  default_post_privacy,
  default_image_privacy
)
select
  discoverable_by_email.i,
  discoverable_by_phone.i,
  discoverable_by_name.i,
  discoverable_by_friend_code.i,
  email_privacy.i,
  phone_privacy.i,
  location_privacy.i,
  birthday_privacy.i,
  default_post_privacy.i,
  default_image_privacy.i
from       (select 0 as i union select 1 as i)                     discoverable_by_email
cross join (select 0 as i union select 1 as i)                     discoverable_by_phone
cross join (select 0 as i union select 1 as i)                     discoverable_by_name
cross join (select 0 as i union select 1 as i)                     discoverable_by_friend_code
cross join (select 0 as i union select 1 as i union select 2 as i) email_privacy
cross join (select 0 as i union select 1 as i union select 2 as i) phone_privacy
cross join (select 0 as i union select 1 as i union select 2 as i) location_privacy
cross join (select 0 as i union select 1 as i union select 2 as i) birthday_privacy
cross join (select 0 as i union select 1 as i union select 2 as i) default_post_privacy
cross join (select 0 as i union select 1 as i union select 2 as i) default_image_privacy;