require 'rubygems'
require 'nokogiri'
require 'open-uri'  
require 'rspec'  




def initialization

	puts " ----> START <----"
	puts "please wait..."
	page_url = "http://annuaire-des-mairies.com/val-d-oise"
	puts page_url
	doc = Nokogiri::HTML(open(page_url))
	puts "INITIALIZATION: #{doc.class}"
	puts "PRESS [ENTER]"
	gets.chomp
	puts doc

	return doc

end





def initialization1

	page_url = "https://www.annuaire-des-mairies.com/95/avernes.html"
	puts page_url
	avernes_url = Nokogiri::HTML(open(page_url))
	puts "INITIALIZATION: #{avernes_url.class}"
	puts avernes_url
	puts "INITIALIZATION: COMPLETE."
	puts "DATA RECOVERY: TOWNHALLS OF VAL D'OISE EMAILS."
	puts "continue? [ENTER]"
	gets.chomp

	return avernes_url

end






def get_avernes_email(avernes_url)

	puts "STEP TEST"
	puts "DATA EXTRACTION: AVERNES EMAIL..."
	puts "continue? [ENTER]"
	gets.chomp
	puts "please wait..."

	avernes_mail = []

	page_url = "http://annuaire-des-mairies.com/95/avernes.html"
	avernes_url = Nokogiri::HTML(open(page_url))
	avernes_url.xpath('/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]').each do |email|
	  avernes_mail << email.text

	end

	puts avernes_mail
	puts "AVERNES MAIL EXTRACTION: COMPLETE."
	puts "continue? [ENTER]"
	gets.chomp

	 return avernes_mail
	
end





def get_townhall_urls(doc)


	puts "STEP 1"
	puts "DATA EXTRACTION: TOWNHALL URLS..."
	puts "continue? [ENTER]"
	gets.chomp
	puts "please wait..."

	townhall_url = []

	doc.xpath('//tr/td/p/a/@href').each do |n|
		townhall_url << n.text

	end

	townhall_url = townhall_url.map {|ve| ve.delete_prefix(".").to_s}
	townhall_url = townhall_url.map {|ve| "http://annuaire-des-mairies.com" + "#{ve}" }

	puts townhall_url
	puts "There are #{townhall_url.length} emails extracted."
	puts "TOWNHALL URLS EXTRACTION: COMPLETE."
	puts "continue? [ENTER]"
	gets.chomp

	return townhall_url
	
end






def get_townhall_email(townhall_url)

	puts "STEP 2"
	puts "DATA EXTRACTION: TOWNHALL EMAILS..."
	puts "continue? [ENTER]"
	gets.chomp
	puts "please wait..."

	townhall_mails = []
	var = 0
	townhall_url[var]

	townhall_url.length.times do 

		page_url = townhall_url[var]
		complete_url = Nokogiri::HTML(open(page_url))
		puts page_url
		complete_url.xpath('/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]').each do |email|
		  	townhall_mails << email.text
		  	puts email.text

		  	var += 1

		end

	end

	puts townhall_mails
	puts "There are #{townhall_mails.length} emails extracted."
	puts "AVERNES MAIL EXTRACTION: COMPLETE."
	puts "continue? [ENTER]"
	gets.chomp

	 return townhall_mails
	
end






def where_townhall(doc, townhall_url)

	puts "STEP 3"
	puts "DATA DETERMINATION: TOWNHALL CITIES..."
	puts "continue? [ENTER]"
	gets.chomp
	puts "please wait..."

	townhall_cities = []

	doc.xpath('//tr/td/p/a').each do |n|
		townhall_cities << n.text

	townhall_cities = townhall_cities.map {|ve| ve.delete_prefix("http://annuaire-des-mairies.com").to_s}	

	end

	puts townhall_cities
	puts "There are #{townhall_cities.length} cities determinated."
	puts "TOWNHALL CITIES DETERMINATION: COMPLETE."
	puts "continue? [ENTER]"
	gets.chomp

	return townhall_cities
end






def organize_hash(townhall_cities, townhall_mails)
	
	puts "STEP 4"
	puts "DATA ARRANGEMENT: IN PROGRESS..."
	puts "continue? [ENTER]"
	gets.chomp
	puts "please wait..."

	townhall_a = townhall_cities.zip(townhall_mails)
	puts townhall_a
	puts "DATA ARRANGEMENT: 50%"
	puts "continue? [ENTER]"
	gets.chomp
	array_of_h = []
	townhall_a.each { |each| array_of_h << { each[0] => each[1]} }

	puts array_of_h
	puts "DATA ARRANGEMENT: COMPLETE."
	puts "continue? [ENTER]"
	gets.chomp

	return array_of_h

end






def perform

	doc = initialization
	avernes_url = initialization1
	avernes_mail = get_avernes_email(avernes_url)
	townhall_url = get_townhall_urls(doc)
	townhall_mails = get_townhall_email(townhall_url)
	
	townhall_cities = where_townhall(doc, townhall_url)
	array_of_h = organize_hash(townhall_cities, townhall_mails)
	
end

perform

puts "DATA RECOVERY: TOWNHALLS OF VAL D'OISE EMAILS ----> DONE."