SELECT pager_number, destination
FROM mds.history 
WHERE received_date = to_date('2016-07-11 07:00:41', 'YYYY-MM-DD HH24:MI:SS');

select pager_number, to_char(received_date, 'YYYY-MM-DD HH24:MI:SS'),
destination from mds.history hi where received_date > to_date
('2016-07-12', 'YYYY-MM-DD') and destination is not null;


SELECT tran_type, prev_booked, original_pager_number, pager_number, roster_id, destination 
FROM mds.history 
WHERE 
	(pager_number = '0000030590' OR pager_number = '0003059000') AND 
	received_date = to_date('2016-07-12 13:35:47', 'YYYY-MM-DD HH24:MI:SS') AND 
	destination = 'sm' AND
	primary_flag = 'P';

--	XOA646V
SELECT *
FROM 
    ( SELECT dt_recvd, dt_pulled, dt_call_start, dt_call_end, delivery_status, contact_made, 
             operator, oc.machine_id, oc.port, result, hi.sequence_number, holder_name, 
             directory_name, directory_type, priority, delivery_type, hi.sent_date, dest, 
             row_number() OVER (PARTITION BY oc.priority ORDER BY hi.destination) AS rn
      FROM mds.mdsoclog oc LEFT OUTER JOIN mds.history hi ON 
          (hi.pager_number_base = oc.pager_num OR hi.original_pager_number = oc.pager_num)
          AND hi.received_date >= to_date(oc.dt_recvd, 'YYYYMMDDHH24MISS')
          AND (oc.dest IS NULL OR hi.destination >= oc.dest)
          AND (hi.send_pager_number IS NULL OR hi.send_pager_number = hi.original_pager_number OR hi.send_pager_number = hi.pager_number_base)
      WHERE oc.roster_id = 'XOA646V')
WHERE rn = 1
AND DT_RECVD >= '20160712000000'
AND DT_RECVD < '20160714000000';

SELECT * FROM scheduled_service_schedule WHERE frequency_type  = 'single' ORDER BY effective_from_date desc;

SELECT * FROM scheduled_service_reminder;

SELECT * FROM scheduled_service_deliverer ORDER BY latest_check_timestamp desc;

select * FROM scheduled_service; 

SELECT * FROM service_item_profile;
	