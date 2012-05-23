
require 'rubygems'
require 'nokogiri'
require 'open-uri'

# Grabbing the Cal Access Page
page =  Nokogiri::HTML(open("http://cal-access.sos.ca.gov/Campaign/Committees/Detail.aspx?id=1342974&session=2011&view=general"))

# Storing info in variables
title = page.css('title').text

# Basic info
campaign_name =  page.css('#lblFilerName').text

filer_id =  page.css('#_ctl3_lblFilerId').text

filer_phone =  page.css('#_ctl3_lblFilerAddress').text

table = page.css('#_ctl3_lblFilerAddressTable + table')

# Nitty gritty

current_status = table.css('tr:nth-child(2) td:nth-child(2)').text
last_report_date = table.css('tr:nth-child(3) td:nth-child(2)').text
reporting_period = table.css('tr:nth-child(4) td:nth-child(2)').text
contributions_this_period = table.css('tr:nth-child(5) td:nth-child(2)').text
total_contributions_this_period = table.css('tr:nth-child(6) td:nth-child(2)').text
expenditures_this_period = table.css('tr:nth-child(7) td:nth-child(2)').text
total_expenditures_this_period = table.css('tr:nth-child(8) td:nth-child(2)').text
ending_cash = table.css('tr:nth-child(9) td:nth-child(2)').text


# Print information to terminal
puts # Spacing is pretty
puts title + "\n" + campaign_name + "\n" + "Filer ID: " + filer_id + "\n" + "Filer Phone: " + filer_phone
puts
puts "Summary for " + campaign_name
puts
puts "Current Status: " + current_status
puts "Last Report Date This Session: " + last_report_date
puts "Reporting Period: " + reporting_period
puts "Contributions from this period: " + contributions_this_period
puts "Total Contributions " + reporting_period + ": " + total_contributions_this_period
puts "Expenditures from this Period: " + expenditures_this_period
puts "Total Expenditures " + reporting_period + ": " + total_expenditures_this_period
puts "Ending Cash: " + ending_cash
puts