### This is Related to Query    } CategoryChange                   #####
##  Date    : 2024-Dec-23                                            ###
##  Subject : Toll Change Collectio                                   ##
##            National Audit Office                                   ##
-- Script Name: ReportCategoryChangeFinal.sql
-- Description: Creates the users table for storing user information.
-- Author:Sohan Dulanjana
-- Created: 2024-12-23



SELECT DATE(`exit_time`),COUNT(*) FROM `tbl_exit_ticket`  
  WHERE DATE(`exit_time`)>='2024-07-14 00:00:00' AND DATE(`exit_time`) < '2024-07-26 00:00:00'
  AND `ticket_type_status_id`=9
  GROUP BY DATE(`exit_time`)
