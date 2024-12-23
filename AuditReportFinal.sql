### This is Related to Query    } Audit Report                     #####
##  Date    : 2024-Dec-23                                            ###
##  Subject : Toll Change Collectio                                   ##
##            National Audit Office                                   ##
-- Script Name: AuditReportFinal.sql
-- Description: Creates the users table for storing user information.
-- Author:Sohan Dulanjana
-- Created: 2024-12-23




*******************************Summery Correct Query Exit**************************

INSERT INTO rpt_hourly_traffic_directional_exit_revenue_summery(exit_ic,day,direction,hour,cat1_count,cat2_count,cat3_count,cat4_count,catS_count,catPS_count,catPMS_count,catAmbulance_count,catNotAssigned_count, cat1_amount,cat2_amount,cat3_amount,cat4_amount,catS_amount,catPS_amount,catPMS_amount,catAmbulance_amount,catNotAssigned_amount)
SELECT 
	tb.exit_ic,
	date(startDate) as day,
	tb.direction,
    hour(startDate) as hour,
	IFNULL(SUM(case when tb.vehicle_category = 1 THEN tb.count END),0) Cat01,
	IFNULL(SUM(case when tb.vehicle_category = 2 THEN tb.count END),0) Cat02,
	IFNULL(SUM(case when tb.vehicle_category = 3 THEN tb.count END),0) Cat03,
	IFNULL(SUM(case when tb.vehicle_category = 4 THEN tb.count END),0) Cat04,
	IFNULL(SUM(case when tb.vehicle_category = 20 THEN tb.count END),0) CatS,
	IFNULL(SUM(case when tb.vehicle_category = 21 THEN tb.count END),0) CatPS,
	IFNULL(SUM(case when tb.vehicle_category = 22 THEN tb.count END),0) CatPMS,
	IFNULL(SUM(case when tb.vehicle_category = 30 THEN tb.count END),0) CatAmbulance,
	IFNULL(SUM(case when tb.vehicle_category = 99 THEN tb.count END),0) CatNotAssigned,
    IFNULL(SUM(case when tb.vehicle_category = 1 THEN tb.amount END),0) Cat01Amount,
	IFNULL(SUM(case when tb.vehicle_category = 2 THEN tb.amount END),0) Cat02Amount,
	IFNULL(SUM(case when tb.vehicle_category = 3 THEN tb.amount END),0) Cat03Amount,
	IFNULL(SUM(case when tb.vehicle_category = 4 THEN tb.amount END),0) Cat04Amount,
	IFNULL(SUM(case when tb.vehicle_category = 20 THEN tb.amount END),0) CatSAmount,
	IFNULL(SUM(case when tb.vehicle_category = 21 THEN tb.amount END),0) CatPSAmount,
	IFNULL(SUM(case when tb.vehicle_category = 22 THEN tb.amount END),0) CatPMSAmount,
	IFNULL(SUM(case when tb.vehicle_category = 30 THEN tb.amount END),0) CatAmbulanceAmount,
	IFNULL(SUM(case when tb.vehicle_category = 99 THEN tb.amount END),0) CatNotAssignedAmount
    
FROM 
(

SELECT d.name AS direction, t.exit_ic,t.vehicle_category ,COUNT(t.vehicle_category) AS count, SUM(t.amount) AS amount FROM 
(
SELECT date(exit_time) AS day, exit_ic,vehicle_category,entrance_ic ,amount FROM `tbl_exit_ticket` 
    where 
     ticket_type_status_id NOT IN (2,12) and
    exit_time >= startDate and exit_time < endDate


    
) t
INNER JOIN tbl_route r ON r.source = t.entrance_ic AND r.destination = t.exit_ic
INNER JOIN tbl_direction d ON r.direction = d.id
GROUP BY d.name, t.exit_ic,t.vehicle_category

) tb
GROUP BY tb.direction,tb.exit_ic
  
_________________________________________________________________________________________________________________________________________________  
  
  
  
  
  
  
  
  
  
  
  
  
  **************************Summery Correct Query Entrance****************************
  
  INSERT INTO rpt_hourly_directional_traffic_entrance2(day,hour,ic_id,direction,cat1_count,cat2_count,cat3_count,cat4_count,catS_count,catPS_count,catPMS_count,catAmbulance_count,catNotAssigned_count)
SELECT
	tb.day,
    tb.hour,
	tb.entrance_ic,
	'DIRECTION'='DEFAULT',
	IFNULL(SUM(case when tb.vehicle_category = 1 THEN tb.count END),0) Cat01,
	IFNULL(SUM(case when tb.vehicle_category = 2 THEN tb.count END),0) Cat02,
	IFNULL(SUM(case when tb.vehicle_category = 3 THEN tb.count END),0) Cat03,
	IFNULL(SUM(case when tb.vehicle_category = 4 THEN tb.count END),0) Cat04,
	IFNULL(SUM(case when tb.vehicle_category = 20 THEN tb.count END),0) CatS,
	IFNULL(SUM(case when tb.vehicle_category = 21 THEN tb.count END),0) CatPS,
	IFNULL(SUM(case when tb.vehicle_category = 22 THEN tb.count END),0) CatPMS,
	IFNULL(SUM(case when tb.vehicle_category = 30 THEN tb.count END),0) CatAmbulance,
	IFNULL(SUM(case when tb.vehicle_category = 99 THEN tb.count END),0) CatNotAssigned
	FROM (
		SELECT 
		tbl.day,
        tbl.hour,
		tbl.booth_id,
		tbl.entrance_ic,
		tbl.vehicle_category,
		tbl.count
		 FROM
			(SELECT 
			date(t.entrance_time) AS day,
            hour(t.entrance_time) AS hour,
			t.booth_id,
			t.entrance_ic,
			t.vehicle_category, 
			COUNT(t.vehicle_category) AS count FROM 
			(
			SELECT * FROM `tbl_entrance_ticket` where entrance_time >= '2024-10-03 00:00:00' and entrance_time < '2024-10-04 00:00:00'
			) t
			
			GROUP BY date(t.entrance_time),hour(t.entrance_time),t.entrance_ic,t.booth_id,t.vehicle_category ) tbl
			
		ORDER BY tbl.day ) tb GROUP BY tb.day, tb.hour,tb.booth_id,
	tb.entrance_ic,
	tb.vehicle_category
   
  
  
  
  
 _________________________________________________________________________________________________________________________________________________ 
  
  
  
  
  
  ********************All Entrance Final Correct***********************
  
  SELECT COUNT(*) FROM `tbl_entrance_ticket` WHERE DATE(`entrance_time`)='2024-10-04';
  
  SELECT COUNT(*),ticket_type_status_id FROM `tbl_entrance_ticket` WHERE DATE(`entrance_time`)='2024-10-05'
  GROUP BY ticket_type_status_id;
  
  SELECT COUNT(*),vehicle_category FROM `tbl_entrance_ticket` WHERE DATE(`entrance_time`)='2024-10-05'
  GROUP BY vehicle_category;
  
    
	
	
	_________________________________________________________________________________________________________________________________________________
	
  
  ********************All Exit Final Correct**************************
  
  SELECT COUNT(*) FROM `tbl_exit_ticket` WHERE DATE(`exit_time`)='2024-10-01';
  
  
  SELECT * FROM `tbl_exit_ticket` WHERE DATE(`exit_time`)='2024-10-04';
  
  #V1.1
  
  SELECT COUNT(*) FROM `tbl_exit_ticket` WHERE DATE(`entrance_time`) BETWEEN ('2024-10-04 00:00:00' 
  AND '2024-10-05 00:00:00') AND DATE(`exit_time`)<='2024-10-05 01:00:00';
  
  #V1.2
  SELECT COUNT(*) FROM `tbl_exit_ticket` WHERE (`entrance_time` >= '2024-10-04 00:00:00' AND `entrance_time` < '2024-10-05 00:00:00') 
  AND `exit_time`<='2024-10-05 01:00:00';
  
  #V1.3
  SELECT COUNT(*) FROM `tbl_exit_ticket` WHERE (`entrance_time` >= '2024-10-04 00:00:00' 
  AND `entrance_time` < '2024-10-05 00:00:00') 
  AND `exit_time`<='2024-10-05 01:00:00'
  AND `ticket_type_status_id` NOT IN (2,12);
  
  
  SELECT COUNT(*) FROM `tbl_exit_ticket` WHERE (`entrance_time` >= '2024-10-04 00:00:00' 
  AND `entrance_time` < '2024-10-05 00:00:00') 
  AND `exit_time`<='2024-10-05 01:00:00'
  AND `ticket_type_status_id` IN (2,12);
  
  ####
  SELECT COUNT(*),et.ticket_type_status_id FROM tbl_exit_ticket et
  WHERE (et.entrance_time >= '2024-10-05 00:00:00' AND et.entrance_time < '2024-10-06 00:00:00') 
  AND et.exit_time<='2024-10-06 01:00:00'
  AND et.ticket_type_status_id NOT IN (2,12)
  GROUP BY et.ticket_type_status_id
  ORDER BY et.ticket_type_status_id;
  
  
  #####
  SELECT COUNT(*),et.vehicle_category FROM tbl_exit_ticket et
  WHERE (et.entrance_time >= '2024-10-05 00:00:00' AND et.entrance_time < '2024-10-06 00:00:00') 
  AND et.exit_time<='2024-10-06 01:00:00'
  AND et.ticket_type_status_id NOT IN (2,12)
  GROUP BY et.vehicle_category;
  
  
  
  
  _________________________________________________________________________________________________________________________________________________
  
  
  
  ****************Exit Without Entrance Barcode*************************
  
  SELECT tbl_exit_ticket.exit_ic,COUNT(*) FROM `tbl_exit_ticket` 
  WHERE (`entrance_time` >= '2024-10-04 00:00:00' 
  AND `entrance_time` < '2024-10-05 00:00:00') 
  AND `exit_time`<='2024-10-05 01:00:00'
  AND tbl_exit_ticket.entrance_barcode NOT IN (SELECT tbl_entrance_ticket.serial_no FROM tbl_entrance_ticket WHERE DATE(tbl_entrance_ticket.entrance_time)='2024-10-04')
  GROUP BY tbl_exit_ticket.exit_ic;
  
  #V1.2
  SELECT tbl_exit_ticket.ticket_type_status_id,COUNT(*) FROM `tbl_exit_ticket` 
  WHERE (`entrance_time` >= '2024-10-05 00:00:00' 
  AND `entrance_time` < '2024-10-06 00:00:00') 
  AND `exit_time`<='2024-10-06 01:00:00'
  AND tbl_exit_ticket.entrance_barcode NOT IN (SELECT tbl_entrance_ticket.serial_no FROM tbl_entrance_ticket WHERE DATE(tbl_entrance_ticket.entrance_time)='2024-10-05')
  AND tbl_exit_ticket.ticket_type_status_id NOT IN (2,12)
  GROUP BY tbl_exit_ticket.ticket_type_status_id;
  
  
  #V1.3
  SELECT tbl_exit_ticket.exit_ic,COUNT(*) FROM `tbl_exit_ticket` 
  WHERE (`entrance_time` >= '2024-10-04 00:00:00' 
  AND `entrance_time` < '2024-10-05 00:00:00') 
  AND `exit_time`<='2024-10-05 01:00:00'
  AND tbl_exit_ticket.entrance_barcode NOT IN (SELECT tbl_entrance_ticket.serial_no FROM tbl_entrance_ticket WHERE DATE(tbl_entrance_ticket.entrance_time)='2024-10-04')
  AND tbl_exit_ticket.ticket_type_status_id NOT IN (2,12)
  GROUP BY tbl_exit_ticket.exit_ic;
  
  
  
  ###IC Wise
  SELECT tbl_exit_ticket.exit_ic,tbl_exit_ticket.entrance_ic,COUNT(*) FROM `tbl_exit_ticket` 
  WHERE (`entrance_time` >= '2024-10-04 00:00:00' 
  AND `entrance_time` < '2024-10-05 00:00:00') 
  AND `exit_time`<='2024-10-05 01:00:00'
  AND tbl_exit_ticket.entrance_barcode NOT IN (SELECT tbl_entrance_ticket.serial_no FROM tbl_entrance_ticket WHERE DATE(tbl_entrance_ticket.entrance_time)='2024-10-04')
  AND tbl_exit_ticket.entrance_barcode LIKE '%000000%'
  GROUP BY tbl_exit_ticket.exit_ic;
  
  
  ###(26,27,28)
  SELECT tbl_exit_ticket.exit_ic,COUNT(*) FROM `tbl_exit_ticket` 
  WHERE (`entrance_time` >= '2024-10-04 00:00:00' 
  AND `entrance_time` < '2024-10-05 00:00:00') 
  AND `exit_time`<='2024-10-05 01:00:00'
  AND tbl_exit_ticket.entrance_barcode NOT IN (SELECT tbl_entrance_ticket.serial_no FROM tbl_entrance_ticket WHERE DATE(tbl_entrance_ticket.entrance_time)='2024-10-04')
  AND tbl_exit_ticket.exit_ic IN (26,27,28)
  GROUP BY tbl_exit_ticket.exit_ic;
  
  
  SELECT * FROM `tbl_exit_ticket` 
  WHERE (`entrance_time` >= '2024-10-04 00:00:00' 
  AND `entrance_time` < '2024-10-05 00:00:00') 
  AND `exit_time`<='2024-10-05 01:00:00'
  AND tbl_exit_ticket.entrance_barcode NOT IN (SELECT tbl_entrance_ticket.serial_no FROM tbl_entrance_ticket WHERE DATE(tbl_entrance_ticket.entrance_time)='2024-10-04')
  LIMIT 50;
  
  
  
  
  
  _________________________________________________________________________________________________________________________________________________
  
  
  
  ***************Complete Entrance Final Correct***********************
  #V1.1
  SELECT COUNT(*) FROM `tbl_entrance_ticket` WHERE DATE(`entrance_time`)='2024-10-01' 
  AND tbl_entrance_ticket.ticket_uuid IN 
  ( SELECT et.ticket_uuid FROM tbl_entrance_ticket AS et 
  INNER JOIN tbl_exit_ticket AS etx ON et.serial_no = etx.entrance_barcode 
  WHERE et.entrance_time >= '2024-10-01 00:00:00' AND et.entrance_time < '2024-10-02 00:00:00' )
  
  
  
  SELECT COUNT(*),ticket_type_status_id FROM `tbl_entrance_ticket` WHERE DATE(`entrance_time`)='2024-10-01' 
  AND tbl_entrance_ticket.ticket_uuid IN 
  ( SELECT et.ticket_uuid FROM tbl_entrance_ticket AS et 
  INNER JOIN tbl_exit_ticket AS etx ON et.serial_no = etx.entrance_barcode 
  WHERE et.entrance_time >= '2024-10-01 00:00:00' AND et.entrance_time < '2024-10-02 00:00:00' )
  GROUP BY ticket_type_status_id
  
  #V1.2
  SELECT COUNT(*),ticket_type_status_id FROM `tbl_entrance_ticket` WHERE DATE(`entrance_time`)='2024-10-04' 
  AND tbl_entrance_ticket.ticket_uuid IN 
  ( SELECT et.ticket_uuid FROM tbl_entrance_ticket AS et 
  INNER JOIN tbl_exit_ticket AS etx ON et.serial_no = etx.entrance_barcode 
  WHERE et.entrance_time >= '2024-10-04 00:00:00' AND et.entrance_time < '2024-10-05 00:00:00' 
  )
  AND tbl_entrance_ticket.ticket_type_status_id IN (1,5,6) --added
  GROUP BY ticket_type_status_id

  #V1.3
  SELECT COUNT(*),ticket_type_status_id FROM `tbl_entrance_ticket` WHERE DATE(`entrance_time`)='2024-10-05' 
  AND tbl_entrance_ticket.ticket_uuid IN 
  ( SELECT et.ticket_uuid FROM tbl_entrance_ticket AS et 
  INNER JOIN tbl_exit_ticket AS etx ON et.serial_no = etx.entrance_barcode 
  WHERE et.entrance_time >= '2024-10-05 00:00:00' AND et.entrance_time < '2024-10-06 00:00:00' 
  )
  AND tbl_entrance_ticket.ticket_type_status_id NOT IN (2,12) --added 2-Reprint 12-Missed Issued
  GROUP BY ticket_type_status_id;  
  
  
  
  
  ###387
  SELECT COUNT(*) FROM `tbl_entrance_ticket` WHERE DATE(`entrance_time`)='2024-10-04' 
  AND tbl_entrance_ticket.ticket_uuid IN 
  ( SELECT et.ticket_uuid FROM tbl_entrance_ticket AS et 
  INNER JOIN tbl_exit_ticket AS etx ON et.serial_no = etx.entrance_barcode 
  WHERE et.entrance_time >= '2024-10-04 00:00:00' AND et.entrance_time < '2024-10-05 00:00:00'
  AND etx.ticket_type_status_id IN (2,12)  )
  
  

  _________________________________________________________________________________________________________________________________________________
  
  
  
  
    ***************InComplete Entrance Final Correct***********************
	
	#V1.0
	SELECT * FROM tbl_entrance_ticket EN1
    LEFT JOIN tbl_exit_ticket EX
	ON EN1.serial_no = EX.entrance_barcode WHERE
	EN1.entrance_time >= '2024-10-04 00:00:00' AND et.entrance_time < '2024-10-05 00:00:00' AND EX.entrance_barcode IS NULL;
	
	#V1.1
  SELECT COUNT(*) FROM `tbl_entrance_ticket` WHERE DATE(`entrance_time`)='2024-10-04' 
  AND tbl_entrance_ticket.ticket_uuid NOT IN 
  ( SELECT et.ticket_uuid FROM tbl_entrance_ticket AS et 
  INNER JOIN tbl_exit_ticket AS etx ON et.serial_no = etx.entrance_barcode 
  WHERE et.entrance_time >= '2024-10-04 00:00:00' AND et.entrance_time < '2024-10-05 00:00:00' )
  
  #V1.2
  SELECT COUNT(*),ticket_type_status_id FROM `tbl_entrance_ticket` WHERE DATE(`entrance_time`)='2024-10-04' 
  AND tbl_entrance_ticket.ticket_uuid NOT IN 
  ( SELECT et.ticket_uuid FROM tbl_entrance_ticket AS et 
  INNER JOIN tbl_exit_ticket AS etx ON et.serial_no = etx.entrance_barcode 
  WHERE et.entrance_time >= '2024-10-04 00:00:00' AND et.entrance_time < '2024-10-05 00:00:00' )
  GROUP BY ticket_type_status_id;
  
  #V1.3
  SELECT COUNT(*),ticket_type_status_id FROM `tbl_entrance_ticket` WHERE DATE(`entrance_time`)='2024-10-04' 
  AND tbl_entrance_ticket.ticket_uuid NOT IN 
  ( SELECT et.ticket_uuid FROM tbl_entrance_ticket AS et 
  INNER JOIN tbl_exit_ticket AS etx ON et.serial_no = etx.entrance_barcode 
  WHERE (et.entrance_time >= '2024-10-04 00:00:00' AND et.entrance_time < '2024-10-05 00:00:00') 
  AND etx.exit_time < '2024-10-05 01:00:00')
  AND ticket_type_status_id NOT IN (2,12)
  GROUP BY ticket_type_status_id;
  
  #V1.4
	SELECT COUNT(*) FROM tbl_entrance_ticket EN1
    LEFT JOIN tbl_exit_ticket EX
	ON EN1.serial_no = EX.entrance_barcode WHERE
	EN1.entrance_time >= '2024-10-05 00:00:00' AND EN1.entrance_time < '2024-10-06 00:00:00' 
	AND EX.entrance_barcode IS NULL;
	
	
	
	####### Serial number and entrance ic wise
	
	SELECT IC.name,COUNT(*) FROM tbl_entrance_ticket EN1
    LEFT JOIN tbl_exit_ticket EX
	ON EN1.serial_no = EX.entrance_barcode
	INNER JOIN tbl_ic IC
	ON EN1.entrance_ic=IC.id
	WHERE
	EN1.entrance_time >= '2024-10-04 00:00:00' AND EN1.entrance_time < '2024-10-05 00:00:00' 
	AND EX.entrance_barcode IS NULL
	GROUP BY EN1.entrance_ic;
	
	
	######## teller wise V1.0
	
	SELECT EN1.teller_id,U.full_name,COUNT(*),LG.shift_id,LG.login_time,LG.logout_time,D.name FROM tbl_entrance_ticket EN1
    LEFT JOIN tbl_exit_ticket EX
	ON EN1.serial_no = EX.entrance_barcode
	INNER JOIN tbl_login_logout_session LG
	ON EN1.shift_id=LG.shift_id
    INNER JOIN user U
    ON EN1.teller_id=U.id
    INNER JOIN tbl_devices D
    ON EN1.device_id=D.id
	WHERE
	EN1.entrance_time >= '2024-10-04 00:00:00' AND EN1.entrance_time < '2024-10-05 00:00:00' 
	AND EX.entrance_barcode IS NULL
	GROUP BY EN1.teller_id;
	
	######## teller wise V1.1
	
	SELECT EN1.teller_id,U.full_name,COUNT(*) FROM tbl_entrance_ticket EN1
    LEFT JOIN tbl_exit_ticket EX
	ON EN1.serial_no = EX.entrance_barcode
	INNER JOIN user U
    ON EN1.teller_id=U.id
    WHERE
	EN1.entrance_time >= '2024-10-04 00:00:00' AND EN1.entrance_time < '2024-10-05 00:00:00' 
	AND EX.entrance_barcode IS NULL
	GROUP BY EN1.teller_id
	
	
	
	
  #V1.5

  need to check entrance ticket when completed date 
  
  SELECT *,EX.exit_time FROM tbl_entrance_ticket EN1
    LEFT JOIN tbl_exit_ticket EX
	ON EN1.serial_no = EX.entrance_barcode WHERE
	EN1.entrance_time >= '2024-10-04 00:00:00' AND EN1.entrance_time < '2024-10-05 00:00:00' AND
	EX.exit_time >= '2024-10-04 00:00:00' AND EX.exit_time < '2024-12-13 00:00:00'
	AND EX.entrance_barcode IS NULL;

#V1.5
	SELECT COUNT(*) FROM tbl_entrance_ticket EN1
    LEFT JOIN tbl_exit_ticket EX
	ON EN1.serial_no = EX.entrance_barcode WHERE
	EN1.entrance_time >= '2024-10-04 00:00:00' AND EN1.entrance_time < '2024-10-05 00:00:00' 
	AND EX.entrance_barcode IS NULL;  
  
  
  
  
  
  SELECT *,etx.exit_time FROM `tbl_entrance_ticket` WHERE DATE(`entrance_time`)='2024-10-04' 
  AND tbl_entrance_ticket.ticket_uuid NOT IN 
  ( SELECT et.ticket_uuid FROM tbl_entrance_ticket AS et 
  INNER JOIN tbl_exit_ticket AS etx ON et.serial_no = etx.entrance_barcode 
  WHERE (et.entrance_time >= '2024-10-04 00:00:00' AND et.entrance_time < '2024-10-05 00:00:00') AND etx.exit_time < '2024-10-05 00:08:00' )
  LIMIT 5;
  
  SELECT etx.exit_time,et.entrance_time,et.ticket_uuid FROM tbl_entrance_ticket AS et INNER JOIN tbl_exit_ticket AS etx ON et.serial_no = etx.entrance_barcode WHERE (et.entrance_time >= '2024-10-04 00:00:00' AND et.entrance_time < '2024-10-05 00:00:00') AND etx.exit_time < '2024-10-05 00:08:00' ORDER BY `etx`.`exit_time` DESC
  
  NOTE: match this query with exit table
  
  
  
  
  
  
  
  
  
  
  
  
 SELECT COUNT(*),ticket_type_status_id FROM `tbl_entrance_ticket` WHERE DATE(`entrance_time`)='2024-10-04' 
  AND tbl_entrance_ticket.ticket_uuid IN 
  ( SELECT et.ticket_uuid FROM tbl_entrance_ticket AS et 
  INNER JOIN tbl_exit_ticket AS etx ON et.serial_no = etx.entrance_barcode 
  WHERE et.entrance_time >= '2024-10-04 00:00:00' AND et.entrance_time < '2024-10-05 00:00:00' 
  )
  AND tbl_entrance_ticket.ticket_type_status_id IN (1,5,6)
  GROUP BY ticket_type_status_id 
  
  
  _________________________________________________________________________________________________________________________________________________
  
  
  
  
  ********************Duplicate serials entrance*******************
  
  SELECT t1.serial_no, COUNT(*) FROM tbl_2024_10_04_01 t1 GROUP BY t1.serial_no HAVING COUNT(*) > 1;
SELECT t1.serial_no, COUNT(*) FROM tbl_2024_10_04_01 t1 GROUP BY t1.serial_no HAVING COUNT(*) > 1



#####exit serial####

SELECT `exit_serial`, COUNT(*) FROM tbl_exit_ticket WHERE (`entrance_time` >= '2024-10-01 00:00:00' 
  AND `entrance_time` < '2024-10-02 00:00:00') 
  AND `exit_time`<='2024-10-02 01:00:00'
GROUP BY `exit_serial` HAVING COUNT(*) > 1;


SELECT * FROM tbl_exit_ticket 
WHERE entrance_barcode IN (SELECT t1.serial_no FROM tbl_2024_10_04_01 t1 GROUP BY t1.serial_no HAVING COUNT(*) > 1) 
ORDER BY `entrance_serial`  ASC
  
  
  
  
  
  
  
  _________________________________________________________________________________________________________________________________________________
  
  
  ***************InComplete Entrance OLD***********************
  
  SELECT *
                        FROM tbl_entrance_ticket EN1
                        LEFT JOIN tbl_exit_ticket EX
ON EN1.serial_no = EX.entrance_barcode WHERE
EN1.entrance_time BETWEEN '2024-10-03 00:00:00' AND '2024-10-04 00:00:00' AND EX.entrance_barcode IS NULL
AND EN1.ticket_type_status_id IN(1,5,6);
  
  
  
  
  
  
  SELECT COUNT(*),ticket_type_status_id FROM `tbl_entrance_ticket` WHERE DATE(`entrance_time`)='2024-10-01' 
  AND tbl_entrance_ticket.ticket_uuid IN 
  ( SELECT et.ticket_uuid FROM tbl_entrance_ticket AS et 
  INNER JOIN tbl_exit_ticket AS etx ON et.serial_no = etx.entrance_barcode 
  WHERE et.entrance_time >= '2024-10-01 00:00:00' AND et.entrance_time < '2024-10-02 00:00:00' )
  GROUP BY ticket_type_status_id
  
  
  SELECT COUNT(*),ticket_type_status_id FROM `tbl_entrance_ticket` WHERE DATE(`entrance_time`)='2024-10-04' 
  AND tbl_entrance_ticket.ticket_uuid NOT IN 
  ( SELECT et.ticket_uuid FROM tbl_entrance_ticket AS et 
  INNER JOIN tbl_exit_ticket AS etx ON et.serial_no = etx.entrance_barcode 
  WHERE et.entrance_time >= '2024-10-04 00:00:00' AND et.entrance_time < '2024-10-05 00:00:00' )
  GROUP BY ticket_type_status_id
  
  
  
  SELECT COUNT(*),ticket_type_status_id FROM `tbl_entrance_ticket` WHERE DATE(`entrance_time`)='2024-10-04' 
  AND tbl_entrance_ticket.ticket_uuid IN 
  ( SELECT et.ticket_uuid FROM tbl_entrance_ticket AS et 
  INNER JOIN tbl_exit_ticket AS etx ON et.serial_no = etx.entrance_barcode 
  WHERE et.entrance_time >= '2024-10-04 00:00:00' AND et.entrance_time < '2024-10-05 00:00:00' 
  )
  AND tbl_entrance_ticket.ticket_type_status_id IN (1,5,6)
  GROUP BY ticket_type_status_id
  
  
  
  
  ____
  
  
  
  
  
  _________________________________________________________________________________________________________________________________________________
  
  Audit report related data- AQ-30
  
  
  ####################### Total No of Entrance Tickets #################
  
  SELECT DATE(`entrance_time`),COUNT(*) FROM `tbl_entrance_ticket` 
  WHERE DATE(`entrance_time`)>='2024-07-14 00:00:00' AND DATE(`entrance_time`) < '2024-07-26 00:00:00'
  GROUP BY DATE(`entrance_time`)
  
  
  
  
  ####################### Incompleted entrance counts ###################
  
  SELECT DATE(EN1.entrance_time),COUNT(*) FROM tbl_entrance_ticket EN1
    LEFT JOIN tbl_exit_ticket EX
	ON EN1.serial_no = EX.entrance_barcode WHERE
	EN1.entrance_time >= '2024-07-14 00:00:00' AND EN1.entrance_time < '2024-07-26 00:00:00' 
	AND EX.entrance_barcode IS NULL
    GROUP BY DATE(EN1.entrance_time)
	
	
	
	################# No of category chang ########################
	
	
  SELECT DATE(`exit_time`),COUNT(*) FROM `tbl_exit_ticket`  
  WHERE DATE(`exit_time`)>='2024-07-14 00:00:00' AND DATE(`exit_time`) < '2024-07-26 00:00:00'
  AND `ticket_type_status_id`=9
  GROUP BY DATE(`exit_time`)
  
  
  
  ####################No of Lost Tickets ##################
  
  SELECT DATE(`exit_time`),COUNT(*) FROM `tbl_exit_ticket`  
  WHERE DATE(`exit_time`)>='2024-07-14 00:00:00' AND DATE(`exit_time`) <= '2024-07-26 00:00:00'
  AND `ticket_type_status_id`=3
  GROUP BY DATE(`exit_time`)
  
  
  
  ################# Incompleted Entrance CKE(Katunayake,Peliyagoda,Kerawalapitiya01,Kerawalapitiya02,Ja-ela) ###############
  
  
  SELECT DATE(EN1.entrance_time),COUNT(*) FROM tbl_entrance_ticket EN1
    LEFT JOIN tbl_exit_ticket EX
	ON EN1.serial_no = EX.entrance_barcode WHERE
	EN1.entrance_time >= '2024-07-14 00:00:00' AND EN1.entrance_time < '2024-07-26 00:00:00' 
	AND EX.entrance_barcode IS NULL
	AND EN1.entrance_ic IN (1,2,26,27,28)
    GROUP BY DATE(EN1.entrance_time)
	
	
	
	_________________________________________________________________________________________________________________________________________________
	
	Audit report related data- AQ-01 (MONTH WISE)
	
	####################### Total No of Entrance Tickets #################
	
	SELECT MONTH(`entrance_time`),COUNT(*) FROM `tbl_entrance_ticket` 
  WHERE DATE(`entrance_time`)>='2024-06-01 00:00:00' AND DATE(`entrance_time`) < '2024-08-01 00:00:00'
  GROUP BY MONTH(`entrance_time`);
  
  
  
  
  ####################### Incompleted entrance counts ###################
  
  SELECT MONTH(EN1.entrance_time),COUNT(*) FROM tbl_entrance_ticket_ar EN1
    LEFT JOIN tbl_exit_ticket_ar EX
	ON EN1.serial_no = EX.entrance_barcode WHERE
	EN1.entrance_time >= '2023-01-01 00:00:00' AND EN1.entrance_time < '2023-07-01 00:00:00' 
	AND EX.entrance_barcode IS NULL
    GROUP BY MONTH(EN1.entrance_time);
	
	
	*********From archived database***********
	
	SELECT MONTH(EN1.entrance_time),COUNT(*) FROM rda_live.tbl_entrance_ticket_ar EN1
    LEFT JOIN rda_ticket_data_archive.tbl_all_exit_ticket EX
	ON EN1.serial_no = EX.entrance_barcode WHERE
	EN1.entrance_time >= '2024-05-01 00:00:00' AND EN1.entrance_time < '2024-06-01 00:00:00' 
	AND EX.entrance_barcode IS NULL
    GROUP BY MONTH(EN1.entrance_time);
  
  
  ################# No of category chang ########################
	
	
  SELECT MONTH(`exit_time`),COUNT(*) FROM `tbl_exit_ticket_ar`  
  WHERE DATE(`exit_time`)>='2023-01-01 00:00:00' AND DATE(`exit_time`) < '2024-01-01 00:00:00'
  AND `ticket_type_status_id`=9
  GROUP BY MONTH(`exit_time`);
  
  *********From archived database***********
	
  SELECT MONTH(`exit_time`),COUNT(*) FROM rda_ticket_data_archive.`tbl_all_exit_ticket`  
  WHERE DATE(`exit_time`)>='2024-01-01 00:00:00' AND DATE(`exit_time`) < '2025-01-01 00:00:00'
  AND `ticket_type_status_id`=9
  GROUP BY MONTH(`exit_time`);
  
  
  ####################No of Lost Tickets ##################
  
  SELECT MONTH(`exit_time`),COUNT(*) FROM `tbl_exit_ticket_ar`  
  WHERE DATE(`exit_time`)>='2023-07-01 00:00:00' AND DATE(`exit_time`) < '2024-01-01 00:00:00'
  AND `ticket_type_status_id`=3
  GROUP BY MONTH(`exit_time`);
  
  
  *********From archived database***********
	
  SELECT MONTH(`exit_time`),COUNT(*) FROM rda_ticket_data_archive.`tbl_all_exit_ticket`  
  WHERE DATE(`exit_time`)>='2024-01-01 00:00:00' AND DATE(`exit_time`) < '2025-01-01 00:00:00'
  AND `ticket_type_status_id`=3
  GROUP BY MONTH(`exit_time`);
  
  
  
  
  ################# Incompleted Entrance CKE(Katunayake,Peliyagoda,Kerawalapitiya01,Kerawalapitiya02,Ja-ela) ###############
  
  
  SELECT MONTH(EN1.entrance_time),COUNT(*) FROM tbl_entrance_ticket_ar EN1
    LEFT JOIN tbl_exit_ticket_ar EX
	ON EN1.serial_no = EX.entrance_barcode WHERE
	EN1.entrance_time >= '2019-11-01 00:00:00' AND EN1.entrance_time < '2020-01-01 00:00:00' 
	AND EX.entrance_barcode IS NULL
	AND EN1.entrance_ic IN (1,205,301,302,303)
    GROUP BY MONTH(EN1.entrance_time);
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  SELECT 
    YEAR(EN1.entrance_time) AS year,
    MONTH(EN1.entrance_time) AS month,
    COUNT(*) AS count
FROM tbl_entrance_ticket_ar EN1
LEFT JOIN tbl_exit_ticket_ar EX
    ON EN1.serial_no = EX.entrance_barcode
WHERE 
    EN1.entrance_time >= '2024-01-01 00:00:00' 
    AND EN1.entrance_time < '2024-08-01 00:00:00'
    AND EX.entrance_barcode IS NULL
GROUP BY YEAR(EN1.entrance_time), MONTH(EN1.entrance_time)
ORDER BY year, month;
  
  
  
  
  
  
  
  
  
  
  
  
  SELECT * FROM tbl_entrance_ticket EN1
    LEFT JOIN tbl_exit_ticket EX
	ON EN1.serial_no = EX.entrance_barcode WHERE
	EN1.entrance_time >= '2024-12-16 00:00:00' AND EN1.entrance_time < '2024-12-17 00:00:00' 
    AND EN1.ticket_type_status_id NOT IN (5,6)
	AND EX.entrance_barcode IS NULL
    AND EN1.booth_id=16
	
	*****Extention****
	SELECT * FROM tbl_entrance_ticket EN1
    LEFT JOIN tbl_exit_ticket EX
	ON EN1.serial_no = EX.entrance_barcode WHERE
	EN1.entrance_time >= '2024-12-17 00:00:00' AND EN1.entrance_time < '2024-12-18 00:00:00' 
    AND EN1.ticket_type_status_id NOT IN (5,6)
	AND EX.entrance_barcode IS NULL
    AND EN1.booth_id IN (156,164,260,148,145,263,327,150,154,379,152,159,364,259,332,289,262)_____________________________________________________________________________________________________________________________________________
