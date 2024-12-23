### This is Related to Query    } EntranceSummery                  #####
##  Date    : 2024-Dec-23                                            ###
##  Subject : Toll Change Collectio                                   ##
##            National Audit Office                                   ##
-- Script Name: Procedure-EntranceSummeryFinal.sql
-- Description: Creates the users table for storing user information.
-- Author:Sohan Dulanjana
-- Created: 2024-12-23



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
