
create event cleanup_sessions
on schedule every 1 day
do
  delete sessions
  from sessions
  where expiration < now();
