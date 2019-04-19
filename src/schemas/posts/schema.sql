
create database viva_posts;
use viva_posts;


-- 
-- Privacy setting rules that can be applied to 
-- 

create table post_privacy_settings (
  id bigint unsigned not null auto_increment,
  user_id bigint unsigned not null,

  -- The base privacy template to extend
  --  0: Private
  --  1: Friends Only
  --  2: Public
  template tinyint(1) not null default 0,

  -- Record metadata
  created_timestamp timestamp not null default now(),
  updated_timestamp timestamp not null default now() on update now(),

  -- Keys/Indexes
  primary key (id),
  index idx_post_privacy_settings_user_id (user_id)
)
engine=InnoDB,
charset=utf8mb4;


-- 
-- Specific individual rules for a post privacy policy
-- 

create table post_privacy_rules (
  post_privacy_settings_id bigint unsigned not null,

  -- Who does this rule apply to (only one of these should be populated per record)
  applies_to_user_id bigint unsigned,  -- FK viva_users.users.id
  applies_to_group_id bigint unsigned,  -- FK viva_users.user_groups.id

  -- Does this make a post visible (1) or not visible (0)
  visibility tinyint(1) not null default 0,

  -- Record metadata
  created_timestamp timestamp not null default now(),
  updated_timestamp timestamp not null default now() on update now(),

  -- Keys/Indexes
  primary key (post_privacy_settings_id, applies_to_user_id, applies_to_group_id),
  index idx_post_privacy_rule_applies_to_user_id (applies_to_user_id),
  index idx_post_privacy_rule_applies_to_group_id (applies_to_group_id),

  -- Foreign Keys
  constraint fk_post_privacy_rules_post_privacy_settings_id
    foreign key (post_privacy_settings_id) references post_privacy_settings (id)
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

  -- If the post was made on a page, the page ID goes here
  page_id int unsigned default null,

  content text,

  -- If this post is assigned to a specific privacy policy, this will reference those rules
  post_privacy_settings_id bigint unsigned,

  -- Controls whether the post shows as "explicit" and requires an opt-in to view
  explicit_content tinyint(1) not null default 0,
  lock_explicit_content tinyint(1) not null default 0,

  -- If a post goes through moderation due to being flagged, and it is determined to not
  -- be in violation of any rules, this bit can be set to mark it as "accepted" and it
  -- can no longer be flagged
  moderator_accepted tinyint(1) not null default 0,

  -- Record metadata
  created_timestamp timestamp not null default now(),
  updated_timestamp timestamp not null default now() on update now(),

  -- Keys/Indexes
  primary key (id),
  index idx_posts_user_id (user_id),
  index idx_posts_page_id (page_id),

  -- Foreign Keys
  constraint fk_posts_post_privacy_settings_id
    foreign key (post_privacy_settings_id) references post_privacy_settings (id)
)
engine=InnoDB,
charset=utf8mb4;


-- 
-- When a user reports a post to be in violation, a record is created here to keep track of
-- specific user that flagged what post, and the reason they provided. This is specifically
-- for tracking down users that abuse the reporting system.
-- 

create table flagged_posts (
  post_id bigint unsigned not null,
  user_id bigint unsigned not null,
  reason varchar(255) not null,

  -- Record metadata
  created_timestamp timestamp not null default now(),
  updated_timestamp timestamp not null default now() on update now(),

  primary key (post_id, user_id),

  -- Foreign Keys
  constraint fk_flagged_posts_post_id
    foreign key (post_id) references posts (id)
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

  content text not null,

  -- Controls whether the post shows as "explicit" and requires an opt-in to view
  explicit_content tinyint(1) not null default 0,
  lock_explicit_content tinyint(1) not null default 0,

  -- If a post goes through moderation due to being flagged, and it is determined to not
  -- be in violation of any rules, this bit can be set to mark it as "accepted" and it
  -- can no longer be flagged
  moderator_accepted tinyint(1) not null default 0,

  -- Record metadata
  created_timestamp timestamp not null default now(),
  updated_timestamp timestamp not null default now() on update now(),

  -- Keys/Indexes
  primary key (id),
  index idx_post_comments_user_id (user_id),

  -- Foreign Keys
  constraint fk_post_comments_post_id
    foreign key (post_id) references posts (id)
)
engine=InnoDB,
charset=utf8mb4;


-- 
-- When a user reports a post to be in violation, a record is created here to keep track of
-- specific user that flagged what post, and the reason they provided. This is specifically
-- for tracking down users that abuse the reporting system.
-- 

create table flagged_post_comments (
  post_comment_id bigint unsigned not null,
  user_id bigint unsigned not null,
  reason varchar(255) not null,

  -- Record metadata
  created_timestamp timestamp not null default now(),
  updated_timestamp timestamp not null default now() on update now(),

  primary key (post_comment_id, user_id),

  -- Foreign Keys
  constraint fk_flagged_posts_post_comment_id
    foreign key (post_comment_id) references post_comments (id)
)
engine=InnoDB,
charset=utf8mb4;
