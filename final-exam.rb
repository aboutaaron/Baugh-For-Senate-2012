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
	candidate_name =  candidates.text
	link_to_candidate = cal_access_url + candidates["href"]

	# Confirming we grabbed the link in case of a slow-ass connection (Hello, Starbucks).
	puts "Just grabbed the page for #{candidate_name}"
	puts "the URL is #{link_to_candidate}"

	# Opening the link
	candidate_page = Nokogiri::HTML(open("#{link_to_candidate}"))

	#####################
	# Candidate Main Page
	#####################

	political_party = candidate_page.css('span.hdr15').text
	current_status = candidate_page.css('td tr:nth-child(2) td:nth-child(2) .txt7').text
	last_report_date = candidate_page.css('td tr:nth-child(3) td:nth-child(2) .txt7').text
	reporting_period = candidate_page.css('td tr:nth-child(4) td:nth-child(2) .txt7').text
	contributions_this_period = candidate_page.css('td tr:nth-child(5) td:nth-child(2) .txt7').text
	total_contributions_this_period = candidate_page.css('td tr:nth-child(6) td:nth-child(2) .txt7').text
	expenditures_this_period = candidate_page.css('td tr:nth-child(7) td:nth-child(2) .txt7').text
	total_expenditures_this_period = candidate_page.css('td tr:nth-child(8) td:nth-child(2) .txt7').text
	ending_cash = candidate_page.css('td tr:nth-child(8) td:nth-child(2) .txt7').text
	
	#####################
	# Hash Browns
	#####################


	#####################
	# Run
	#####################
	puts "Info for #{candidate_name}."
	puts
	puts "Political Party: #{political_party}"
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

puts "A list of candidates without data:"
puts
campaign_data.css('.txt7').each do |other|
	puts other.text
end

puts
puts "Thanks for Playing."