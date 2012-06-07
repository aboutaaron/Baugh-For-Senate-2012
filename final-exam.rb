require 'rubygems'
require 'open-uri'
require 'nokogiri'

# Homepage of Elected Officials and Candidates running for California State Senate 2012
campaign_data =  Nokogiri::HTML(open('http://cal-access.sos.ca.gov/Campaign/Candidates/'))

##########################
# Creating Candidate Class
##########################
class Candidate
	def initialize(url)
		@url = url
		@cal_access_url = "http://cal-access.sos.ca.gov"
		@nodes =  Nokogiri::HTML(open(@cal_access_url + @url))
	end

	def get_summary
		candidate_page = @nodes

		{
			:political_party => candidate_page.css('span.hdr15').text,
			:current_status => candidate_page.css('td tr:nth-child(2) td:nth-child(2) .txt7')[0].text,
			:last_report_date => candidate_page.css('td tr:nth-child(3) td:nth-child(2) .txt7')[0].text,
			:reporting_period => candidate_page.css('td tr:nth-child(4) td:nth-child(2) .txt7')[0].text,
			:contributions_this_period => candidate_page.css('td tr:nth-child(5) td:nth-child(2) .txt7')[0].text.gsub(/[$,](?=\d)/, ''),
			:total_contributions_this_period => candidate_page.css('td tr:nth-child(6) td:nth-child(2) .txt7')[0].text.gsub(/[$,](?=\d)/, ''),
			:expenditures_this_period => candidate_page.css('td tr:nth-child(7) td:nth-child(2) .txt7')[0].text.gsub(/[$,](?=\d)/, ''),
			:total_expenditures_this_period => candidate_page.css('td tr:nth-child(8) td:nth-child(2) .txt7')[0].text.gsub(/[$,](?=\d)/, ''),
			:ending_cash => candidate_page.css('td tr:nth-child(9) td:nth-child(2) .txt7')[0].text.gsub(/[$,](?=\d)/, '')
		}
	end

	def get_contributors
		contributions_received = @nodes
		grab_contributor_page = @nodes.css("a.sublink6")[0]['href']
	    contributor_page = Nokogiri::HTML(open(@cal_access_url + grab_contributor_page))
	    # Opening 25th indexed anchor element - Contributions received
	    grab_contributions_page = contributor_page.css("a")[25]["href"]
	    contributions_received = Nokogiri::HTML(open(@cal_access_url + grab_contributions_page))
	    puts
	    puts "#{@cal_access_url}" + "#{grab_contributions_page}"
	    puts

	    contributions_received.css("table").reduce([]) do |memo, contributors|
	    	begin

	    		memo << {
					:name_of_contributor => contributions_received.css("tr:nth-child(2) td:nth-child(1) .txt7:first")[0].text
				}

			rescue NoMethodError => e
				puts e.message
				puts "Error on #{contributors}"
			end
			memo
		end
	end

end

###############
# Begin scraper
###############
campaign_data.css('a.sublink2').each do |candidates|
	# Confirming we grabbed the link in case of a slow-ass connection (Hello, Starbucks).
	puts "Just grabbed the page for " + candidates.text
	# Initialize Candidate class and print Hash of summary data
	candidate = Candidate.new(candidates["href"])
	p candidate.get_summary
	puts
	p candidate.get_contributors
	# Opening 25th indexed anchor element - Contributions received
	# grab_contributions_page = contributor_page.css("a")[25]["href"]
	puts
end

###########
# Finish up
###########
puts "A list of candidates without data:"
puts
campaign_data.css('.txt7').each do |other|
	{
		:dataless_candidate => other.text
	}
end

puts
puts "Thanks for Playing."