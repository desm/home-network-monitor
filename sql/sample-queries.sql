select *
from ping_stats;

select from_unixtime(timestamp), status
from ping_stats;

select CONVERT_TZ(FROM_UNIXTIME(timestamp), 'UTC', 'America/New_York'), status
from ping_stats
order by timestamp desc
    limit 20;

select CONVERT_TZ(FROM_UNIXTIME(1728774185), 'UTC', 'America/New_York');

-- count stats
select count(*)
from ping_stats;

-- last 1 day
select
    CONVERT_TZ(FROM_UNIXTIME(timestamp), 'UTC', 'America/New_York') as time,
    case
        when status = 'u' then 1
        when status = 'd' then 0
end as status
from ping_stats
where timestamp > UNIX_TIMESTAMP(NOW() - INTERVAL 1 DAY);

-- hour X of past 24 hours
select
    FROM_UNIXTIME(timestamp) as time, -- intellij graph tool will convert to our timezone
    case
        when status = 'u' then 1
        when status = 'd' then 0
        end as status
from ping_stats
WHERE
    HOUR(CONVERT_TZ(FROM_UNIXTIME(timestamp), 'UTC', 'America/New_York')) = 21 -- set hour here
    AND timestamp > UNIX_TIMESTAMP(NOW() - INTERVAL 24 HOUR);
