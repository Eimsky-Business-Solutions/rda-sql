### This is Related to Query    } Incompleted Entrance Ticket      #####
##  Date    : 2024-Dec-23                                            ###
##  Subject : Toll Change Collectio                                   ##
##            National Audit Office                                   ##
-- Script Name: AuditReportFinal.sql
-- Description: Creates the users table for storing user information.
-- Author:Sohan Dulanjana
-- Created: 2024-12-23




Incompleted Entrance Tikcets Count
#V1.4

SELECT COUNT(*) FROM tbl_entrance_ticket EN1
    LEFT JOIN tbl_exit_ticket EX
	ON EN1.serial_no = EX.entrance_barcode WHERE
	EN1.entrance_time >= '2024-10-05 00:00:00' AND EN1.entrance_time < '2024-10-06 00:00:00' 
	AND EX.entrance_barcode IS NULL;
