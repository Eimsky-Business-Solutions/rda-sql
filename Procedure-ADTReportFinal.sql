### This is Related to Query    }   ADT Report                      #####
##  Date    : 2024-Dec-23                                             ###
##  Subject : Toll Change Collectio                                   ##
##            National Audit Office                                   ##
-- Script Name: Procedure-ADTReportFinal.sql
-- Description: Creates the users table for storing user information.
-- Author: Shiran Basnayake
-- Modified: Sohan Dulanjana
-- Created: 2024-12-23






INSERT INTO tbl_adt_report_data(year, month, entrance_ic, exit_ic, direction_id,count)
SELECT 
YEAR(ex.entrance_time) AS year,
MONTH(ex.entrance_time) AS month,
ex.entrance_ic AS entrance_ic,
ex.exit_ic AS exit_ic,
r.direction AS direction_id,
COUNT(*) AS count
FROM tbl_route r 
INNER JOIN tbl_exit_ticket ex ON r.source = ex.entrance_ic AND r.destination = ex.exit_ic
WHERE YEAR(ex.entrance_time) = year_in AND MONTH(ex.entrance_time) = month_in
GROUP BY ex.entrance_ic, ex.exit_ic
ORDER BY ex.entrance_ic, ex.exit_ic
ON DUPLICATE KEY UPDATE
count = VALUES(count)
