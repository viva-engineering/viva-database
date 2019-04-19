
create database viva_i18n;
use viva_i18n;


-- 
-- Contains a list of valid languages for i18n
-- 

create table i18n_languages (
  code varchar(255) not null,
  description varchar(255) not null,
  native_description varchar(255) not null,
  active tinyint(1) not null default 0,

  -- Record metadata
  created_timestamp timestamp not null default now(),
  updated_timestamp timestamp not null default now() on update now(),

  -- Keys/Indexes
  primary key (code)
)
engine=InnoDB,
charset=utf8mb4;


-- 
-- Contains a list of valid components for i18n labels
-- 

create table i18n_components (
  code varchar(255) not null,
  description varchar(255) not null,

  -- Record metadata
  created_timestamp timestamp not null default now(),
  updated_timestamp timestamp not null default now() on update now(),

  -- Keys/Indexes
  primary key (code)
)
engine=InnoDB,
charset=utf8mb4;


-- 
-- Contains a list of valid i18n labels
-- 

create table i18n_labels (
  code varchar(255) not null,
  component_code varchar(255) not null,
  description varchar(255) not null,

  -- Record metadata
  created_timestamp timestamp not null default now(),
  updated_timestamp timestamp not null default now() on update now(),

  -- Keys/Indexes
  primary key (code, component_code),

  -- Foreign Keys
  constraint fk_i18n_labels_component_code
    foreign key (component_code) references i18n_components (code)
)
engine=InnoDB,
charset=utf8mb4;


-- 
-- Contains all of the actual translated text for i18n
-- 

create table i18n_translations (
  component_code varchar(255) not null,
  label_code varchar(255) not null,
  language_code varchar(255) not null,
  label_text text not null,

  -- Record metadata
  created_timestamp timestamp not null default now(),
  updated_timestamp timestamp not null default now() on update now(),

  -- Keys/Indexes
  primary key (component_code, label_code, language_code),

  -- Foreign Keys
  constraint fk_i18n_translations_label
    foreign key (label_code, component_code) references i18n_labels (code, component),
  constraint fk_i18n_translations_language_code
    foreign key (language_code) references i18n_languages (code)
)
engine=InnoDB,
charset=utf8mb4;


-- 
-- Generates the list of valid i18n languages
-- 

insert into i18n_languages
  (code, description, native_description, active)
values
  ('en-us', 'English (United States)', 'English (United States)', 1);
