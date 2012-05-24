require "rubygems"
require "nokogiri"
require "open-uri"

###################################
# Variables
###################################
page =  Nokogiri::HTML(open('http://cal-access.sos.ca.gov/Campaign/Committees/Detail.aspx?id=1342974&session=2011&view=received'))

title =  page.css('title').text

###################################
# Run
###################################
puts title

page.css("table").each do |contributions|
	# Second Cell
	puts ""
	puts "Name of Contributor: " + contributions.css('tr:nth-child(2) td:nth-child(1)').text
	puts "Payment Type: " + contributions.css('tr:nth-child(2) td:nth-child(2)').text
	puts "City: " + contributions.css('tr:nth-child(2) td:nth-child(3)').text
	puts "State/ZIP: " + contributions.css('tr:nth-child(2) td:nth-child(4)').text
	# Fourth Cell
	puts "ID Number: " + contributions.css('tr:nth-child(4) td:nth-child(1)').text
	puts "Employer: " + contributions.css('tr:nth-child(4) td:nth-child(2)').text
	puts "Occupation: " + contributions.css('tr:nth-child(4) td:nth-child(3)').text
	# Sixth Cell
	puts "Amount: " + contributions.css('tr:nth-child(6) td:nth-child(1)').text
	puts "Transaction Date: " + contributions.css('tr:nth-child(6) td:nth-child(3)').text
	puts "Filed Date: " + contributions.css('tr:nth-child(6) td:nth-child(4)').text
	puts "Transaction ID: " + contributions.css('tr:nth-child(6) td:nth-child(5)').text
	puts ""
end

class Scraper
	def initialize(url)
		@url = url
	end

	def get
		html = open(url).read
		# Work here
	end
end