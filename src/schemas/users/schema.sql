
create database viva_users;
use viva_users;


-- Reference table containing all possible privacy setting combinations
-- Each user will reference one of these setting combinations
-- (2 ** 3) * (3 ** 6) = 5833 records
create table user_privacy_settings (
  id int unsigned not null auto_increment,

  -- Discoverability values: control how a user can be found by other users
  --  0 = Private, not discoverable by this value
  --  1 = Public, user can be discovered by searching for this value
  discoverable_by_email tinyint(1) not null,
  discoverable_by_phone tinyint(1) not null,
  discoverable_by_name tinyint(1) not null,

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

  -- Primary Key
  primary key (id),

  -- Index including all values, used when looking up a privacy profile to assign to a user
  unique key idx_user_privacy_settings_full (
    discoverable_by_email, discoverable_by_phone, discoverable_by_name,
    email_privacy, phone_privacy, location_privacy, birthday_privacy,
    default_post_privacy, default_image_privacy
  )
)
engine=InnoDB,
charset=utf8mb4;


-- 
-- Contains all of the valid user roles
-- 

create table user_roles (
  id smallint unsigned not null,
  description varchar(255) not null,

  -- Record metadata
  created_timestamp timestamp not null default now(),
  updated_timestamp timestamp not null default now() on update now(),

  -- Keys/Indexes
  primary key (id)
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

  -- The preferred language for the user
  preferred_language varchar(255) default null,

  -- Randomly generated user code used for looking up the user's profile from outside
  -- the service layer. Anyone who has this code can find this user's profile (although
  -- they may not be able to see much beyond that depending on other settings)
  user_code varchar(255) unique not null collate utf8mb4_bin,

  -- Status fields
  active tinyint(1) not null default 1,
  email_validated tinyint(1) not null default 0,

  -- Explicit content flags
  explicit_content_visible tinyint(1) not null default 0,

  -- Elevated permissions roles
  user_role_id smallint unsigned default null,

  -- User's privacy settings configuration
  privacy_settings_id int unsigned not null,

  -- Administrative locks. These fields are used to enable admins and moderators to lock
  -- attributes on a user's account to prevent the user from being able to edit them.
  lock_active tinyint(1) not null default 0,
  lock_explicit_content_visible tinyint(1) not null default 0,

  -- Record metadata
  created_timestamp timestamp not null default now(),
  updated_timestamp timestamp not null default now() on update now(),

  -- Keys/Indexes
  primary key (id),
  index idx_users_email (email),
  index idx_users_name (name),
  index idx_users_user_code (user_code),
  index idx_email_validated (email_validated),

  -- Foreign Keys
  constraint fk_user_privacy_settings_id
    foreign key (privacy_settings_id) references user_privacy_settings (id),
  constraint fk_user_user_role_id
    foreign key (user_role_id) references user_roles (id)
)
engine=InnoDB,
charset=utf8mb4;


-- 
-- Contains user-defined user groups
-- 

create table user_groups (
  id bigint unsigned not null auto_increment,
  user_id bigint unsigned not null,
  name varchar(255) not null,

  -- Record metadata
  created_timestamp timestamp not null default now(),
  updated_timestamp timestamp not null default now() on update now(),

  -- Keys/Indexes
  primary key (id),
  index idx_user_groups_user_id (user_id),

  -- Foreign Keys
  constraint fk_user_groups_user_id
    foreign key (user_id) references users (id)
)
engine=InnoDB,
charset=utf8mb4;



-- 
-- Join table to find all users belonging to a given user group
-- 

create table user_group_users (
  user_group_id bigint unsigned not null,
  user_id bigint unsigned not null,

  -- Record metadata
  created_timestamp timestamp not null default now(),
  updated_timestamp timestamp not null default now() on update now(),

  -- Keys/Indexes
  primary key (user_group_id, user_id),

  -- Foreign Keys
  constraint fk_user_groups_users_user_group_id
    foreign key (user_group_id) references user_groups (id),
  constraint fk_user_groups_users_user_id
    foreign key (user_id) references users (id)
)
engine=InnoDB,
charset=utf8mb4;


-- 
-- A place for moderators to store notes relating to moderation actions taken
-- 

create table moderator_notes (
  id bigint unsigned auto_increment not null,
  user_id bigint unsigned not null,
  note text not null,

  -- The user that made the note
  added_by bigint unsigned not null,

  -- Record metadata
  created_timestamp timestamp not null default now(),
  updated_timestamp timestamp not null default now() on update now(),

  -- Keys/Indexes
  primary key (id),
  index idx_moderator_notes_user_id (user_id),

  -- Foreign Keys
  constraint fk_moderator_notes_user_id
    foreign key (user_id) references users (id),
  constraint fk_moderator_notes_added_by
    foreign key (added_by) references users (id)
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
  index idx_applications_approved (approved),

  -- Foreign Keys
  constraint fk_applications_owner_user_id
    foreign key (owner_user_id) references users (id)
)
engine=InnoDB,
charset=utf8mb4;


-- 
-- User applications table
-- Keeps track of what applications have been granted access to which users
-- 

create table user_applications (
  id bigint unsigned not null auto_increment,
  user_id bigint unsigned not null,
  application_id int unsigned not null,
  user_key_digest varchar(255) not null,

  -- Whether this app is active for this user. All apps default to inactive until
  -- the user chooses to approve them. At that point, the user key is generated
  active tinyint(1) not null default 0,

  -- Record metadata
  created_timestamp timestamp not null default now(),
  updated_timestamp timestamp not null default now() on update now(),

  -- Keys/Indexes
  primary key (id),
  index idx_user_applications_user_id_application_id (user_id, application_id),

  -- Foreign Keys
  constraint fk_user_applications_user_id
    foreign key (user_id) references users (id),
  constraint fk_user_applications_application_id
    foreign key (application_id) references applications (id)
)
engine=InnoDB,
charset=utf8mb4;


-- 

-- Sessions table
-- Contains any active user sessions
-- 

create table sessions (
  id varchar(255) not null collate utf8mb4_bin,
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
  primary key (user_id),

  -- Foreign Keys
  constraint fk_credentials_user_id
    foreign key (user_id) references users (id)
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

  -- Controls whether the page is private; Private pages require approval by the
  -- page owner to view its contents
  is_private tinyint(1) not null default 0,

  -- Controls whether the page shows as "explicit" and requires an opt-in to view
  explicit_content tinyint(1) not null default 0,
  lock_explicit_content tinyint(1) not null default 0,

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
-- Pages follows table
-- Keeps track of which users are following which pages
-- 

create table page_follows (
  page_id int unsigned not null,
  user_id bigint unsigned not null,

  -- For private pages, this flag will first be set to 0, then be updated to 1
  -- when the page owner approves the follow
  approved tinyint(1) not null,

  -- Record metadata
  created_timestamp timestamp not null default now(),
  updated_timestamp timestamp not null default now() on update now(),

  -- Keys/Indexes
  primary key (page_id, user_id),
  index idx_page_follows_user_id (user_id),

  -- Foreign Keys
  constraint fk_page_follows_user_id
    foreign key (user_id) references users (id),
  constraint fk_page_follows_page_id
    foreign key (page_id) references pages (id)
)
engine=InnoDB,
charset=utf8mb4;


-- 
-- Populates the user roles table with all valid roles
-- 

insert into user_roles
  (id, description)
values
  (1, 'SYSTEM'),
  (2, 'ADMIN'),
  (3, 'SUPER_MODERATOR'),
  (4, 'MODERATOR'),
  (5, 'LOCALIZATION');


-- 
-- Generates all the possible combinations of privacy settings to populate the table
-- 

insert into user_privacy_settings
(
  discoverable_by_email,
  discoverable_by_phone,
  discoverable_by_name,
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
  email_privacy.i,
  phone_privacy.i,
  location_privacy.i,
  birthday_privacy.i,
  default_post_privacy.i,
  default_image_privacy.i
from       (select 0 as i union select 1 as i)                     discoverable_by_email
cross join (select 0 as i union select 1 as i)                     discoverable_by_phone
cross join (select 0 as i union select 1 as i)                     discoverable_by_name
cross join (select 0 as i union select 1 as i union select 2 as i) email_privacy
cross join (select 0 as i union select 1 as i union select 2 as i) phone_privacy
cross join (select 0 as i union select 1 as i union select 2 as i) location_privacy
cross join (select 0 as i union select 1 as i union select 2 as i) birthday_privacy
cross join (select 0 as i union select 1 as i union select 2 as i) default_post_privacy
cross join (select 0 as i union select 1 as i union select 2 as i) default_image_privacy;


-- 
-- Runs once a day, deleting any user records more than 4 days old that have not verified their email address
-- 

create event cleanup_incomplete_registrations
on schedule every 1 day
do
  delete users
  from users
  where date_add(created_timestamp, interval 4 day) < now()
    and email_validated = 0;



-- 
-- Runs once a day, deleting any expired sessions
-- 

create event cleanup_sessions
on schedule every 1 day
do
  delete sessions
  from sessions
  where expiration < now();

