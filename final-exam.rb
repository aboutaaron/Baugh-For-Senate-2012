require 'rubygems'
require 'open-uri'
require 'nokogiri'

# Homepage of Elected Officials and Candidates running for California State Senate 2012
campaign_data =  Nokogiri::HTML(open('http://cal-access.sos.ca.gov/Campaign/Candidates/'))

# Grab Each Candidate link the
campaign_data.css('a.sublink2').each do |candidates|
	# Base URL
	cal_access_url = "http://cal-access.sos.ca.gov"

	#Grab Each Link
	link_to_candidate = cal_access_url + candidates["href"]

	# Confirming we grabbed the link in case of a slow-ass connection (Hello, Starbucks).
	puts "Just grabbed #{link_to_candidate}"

	# Opening the link
	candidate_page =  Nokogiri::HTML(open(link_to_candidate))
	
	# Printing some information to the Terminal for great success!

	candidate_name =  candidate_page.css('span#lblFilerName').text
	
	puts "...and the candidate's name is #{candidate_name}"
	puts

	#####################
	# Candidate Main Page
	#####################

	# *IMPORTANT* Remember Aaron, the page variable is `candidate_page`

	filer_id =  candidate_page.css('#_ctl3_lblFilerId').text
	filer_phone =  candidate_page.css('#_ctl3_lblFilerAddress').text

	# Here we go
	table = candidate_page.css('#_ctl3_lblFilerAddressTable + table')

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
	puts "Info for #{candidate_name}. The File ID is #{filer_id}. The phone number is #{filer_phone}"
	puts
	puts "Summary for #{candidate_name}"
	puts
	puts "Current Status: #{current_status}"
	puts "Last Report Date This Session: #{last_report_date}"
	puts "Reporting Period: #{reporting_period}"
	puts "Contributions from this period: #{contributions_this_period}"
	puts "Total Contributions #{reporting_period}: #{total_contributions_this_period}"
	puts "Expenditures from this Period: #{expenditures_this_period}"
	puts "Total Expenditures #{reporting_period}: #{total_expenditures_this_period}"
	puts "Ending Cash: #{ending_cash}"
	puts

end