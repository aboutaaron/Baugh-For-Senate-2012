require 'rubygems'
require 'open-uri'
require 'nokogiri'

# Homepage of Elected Officials and Candidates running for California State Senate 2012
campaign_data =  Nokogiri::HTML(open('http://cal-access.sos.ca.gov/Campaign/Candidates/'))

##########################
# Creating Candidate Class
##########################
class Candidate
	def initialize(summary_url)
		@summary_url = summary_url
		# @contributors_url = contributors_url
	end

	def get_summary
		candidate_page = Nokogiri::HTML(open(@summary_url))

		{
			:political_party => candidate_page.css('span.hdr15').text,
			:current_status => candidate_page.css('td tr:nth-child(2) td:nth-child(2) .txt7:first').text,
			:last_report_date => candidate_page.css('td tr:nth-child(3) td:nth-child(2) .txt7:first').text,
			:reporting_period => candidate_page.css('td tr:nth-child(4) td:nth-child(2) .txt7:first').text,
			:contributions_this_period => candidate_page.css('td tr:nth-child(5) td:nth-child(2) .txt7:first').text.gsub(/[$,](?=\d)/, ''),
			:total_contributions_this_period => candidate_page.css('td tr:nth-child(6) td:nth-child(2) .txt7:first').text.gsub(/[$,](?=\d)/, ''),
			:expenditures_this_period => candidate_page.css('td tr:nth-child(7) td:nth-child(2) .txt7:first').text.gsub(/[$,](?=\d)/, ''),
			:total_expenditures_this_period => candidate_page.css('td tr:nth-child(8) td:nth-child(2) .txt7:first').text.gsub(/[$,](?=\d)/, ''),
			:ending_cash => candidate_page.css('td tr:nth-child(9) td:nth-child(2) .txt7:first').text.gsub(/[$,](?=\d)/, '')
		}
	end
end

###############
# Begin scraper
###############
campaign_data.css('a.sublink2').each do |candidates|
	
	# Setting some variables
	candidate_name =  candidates.text
	cal_access_url = "http://cal-access.sos.ca.gov"
	link_to_candidate = cal_access_url + candidates["href"]

	# Confirming we grabbed the link in case of a slow-ass connection (Hello, Starbucks).
	puts "Just grabbed the page for #{candidate_name}"
	puts "the URL is #{link_to_candidate}"

	# Initialize Candidate class and print Hash
	p Candidate.new("http://cal-access.sos.ca.gov" + candidates["href"]).get_summary.get_contributions
	puts
end

###########
# Finish up
###########
puts "A list of candidates without data:"
puts
campaign_data.css('.txt7').each do |other|
	puts other.text
end

puts
puts "Thanks for Playing."