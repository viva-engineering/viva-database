
create database viva;

use viva;

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

  -- Searchability controls
  friend_code varchar(255) unique not null,
  discoverable_by_email tinyint(1) not null default 0,
  discoverable_by_name tinyint(1) not null default 0,
  discoverable_by_phone tinyint(1) not null default 0,
  discoverable_by_friend_code tinyint(1) not null default 1,

  -- Status fields
  active tinyint(1) not null default 1,
  email_validated tinyint(1) not null default 0,

  -- Explicit content flags
  contains_explicit_content tinyint(1) not null default 0,
  explicit_content_visible tinyint(1) not null default 0,

  -- Elevated permissions flags
  is_admin tinyint(1) not null default 0,
  is_moderator tinyint(1) not null default 0,

  -- Record metadata
  created_timestamp timestamp not null default now(),
  updated_timestamp timestamp not null default now() on update now(),

  -- Keys/Indexes
  primary key (id),
  index idx_users_email (email, discoverable_by_email),
  index idx_users_name (name, discoverable_by_name),
  index idx_users_friend_code (friend_code, discoverable_by_friend_code)
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

