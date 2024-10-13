select *
from ping_stats;

select from_unixtime(timestamp), status
from ping_stats;

select CONVERT_TZ(FROM_UNIXTIME(timestamp), 'UTC', 'America/New_York'), status
from ping_stats
order by timestamp desc
    limit 20;

select CONVERT_TZ(FROM_UNIXTIME(1728774185), 'UTC', 'America/New_York');

-- last 1 day
select
    CONVERT_TZ(FROM_UNIXTIME(timestamp), 'UTC', 'America/New_York') as time,
    case
        when status = 'u' then 1
        when status = 'd' then 0
end as status
from ping_stats
where timestamp > UNIX_TIMESTAMP(NOW() - INTERVAL 1 DAY);

select count(*)
from ping_stats;
