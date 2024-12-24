### This is Related to Query    } EntranceSummery                  #####
##  Date    : 2024-Dec-23                                            ###
##  Subject : Toll Change Collectio                                   ##
##            National Audit Office                                   ##
-- Script Name: Procedure-EntranceSummeryFinal.sql
-- Description: Creates the users table for storing user information.
-- Author:Sohan Dulanjana
-- Created: 2024-12-23



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
