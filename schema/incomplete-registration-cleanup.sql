
-- Runs once a day, deleting any user records more than 4 days old that have not verified their email address

create event cleanup_incomplete_registrations
on schedule every 1 day
do
  delete users
  from users
  where date_add(created_timestamp, interval 4 day) < now()
  	and email_validated = 0;
