require 'rubygems'
require 'nokogiri'
require 'open-uri'  




def initialization

	puts "----> START <----"
	puts "please wait..."
	page_url = "http://www2.assemblee-nationale.fr/deputes/liste/alphabetique"
	doc = Nokogiri::HTML(open(page_url))
	puts page_url
	puts "INITIALIZATION: #{doc.class}"
	puts "PRESS [ENTER]"
	gets.chomp
	puts doc
	puts "INITIALIZATION: COMPLETE."
	puts "DATA RECOVERY: DEPUTY INFORMATIONS."
	puts "continue? [ENTER]"
	gets.chomp

	return doc

end






def get_abadie_data

	puts "STEP TEST"
	puts "DATA EXTRACTION TEST: CAROLINE ABADIE DATA..."
	puts "A first test operation to see if data extraction is working well."
	puts "We will use CAROLINE ABADIE's data to test data extraction."
	puts "continue? [ENTER]"
	gets.chomp

	abadie_mail = []
	abadie_fullname = []
	array_of_h = []


	page_url = "http://www2.assemblee-nationale.fr/deputes/fiche/OMC_PA719866"
	abadie_url = Nokogiri::HTML(open(page_url))
	puts page_url
	puts abadie_url.class

	abadie_url.xpath('//dd[4]/ul/li[2]/a').each do |email|
	  abadie_mail << email.text

	end

	abadie_url.xpath('//article/div[2]/h1').each do |n|
	  abadie_fullname << n.text

	end

	abadie_mail = abadie_mail.join(' ')
	puts "1) Email is : #{abadie_mail} and it is a #{abadie_mail.class}."

	abadie_fullname = abadie_fullname.map {|ve| ve.delete_prefix("Mme ").to_s}
	abadie_fullname = abadie_fullname.join(" ")
	puts "2) Fullname is : #{abadie_fullname} and it is a #{abadie_fullname.class}."

	abadie_splitname = abadie_fullname.split(" ")
	puts "3) Splitname is : #{abadie_splitname} and it is a #{abadie_splitname.class}."

	abadie_firstname = abadie_splitname.delete_at(0)
	puts "4) Firstname is : #{abadie_firstname} and it is a #{abadie_firstname.class}."

	abadie_lastname = abadie_splitname.join(" ")
	puts "5) Lastname is : #{abadie_lastname} and it is a #{abadie_lastname.class}."

	abadie_aoh = [{ "first_name" => abadie_firstname, "last_name" => abadie_lastname,"email" => abadie_mail }]
	puts "6) Array with all data is : #{abadie_aoh} and it is a #{abadie_aoh.class}."

	puts "END."

	puts "CAROLINE ABADIE DATA EXTRACTION: TEST COMPLETE."
	puts "continue? [ENTER]"
	gets.chomp

	 return abadie_mail
	
end






def get_urls(doc)


	puts "STEP 1"
	puts "DATA EXTRACTION: DEPUTY URLS..."
	puts "continue? [ENTER]"
	gets.chomp
	puts "please wait..."

	deputy_url = []

	doc.xpath('//*[@id="deputes-list"]/div/ul/li/a/@href').each do |n|
		deputy_url << n.text

	end

	deputy_url = deputy_url.map {|ve| ve.delete_prefix(".").to_s}
	deputy_url = deputy_url.map {|ve| "http://www2.assemblee-nationale.fr" + "#{ve}" }

	puts deputy_url

	puts "There are #{deputy_url.length} urls extracted."
	puts "DEPUTY URLS EXTRACTION: COMPLETE."
	puts "continue? [ENTER]"
	gets.chomp

	return deputy_url
	
end






def get_names(doc)

	puts "STEP 2"
	puts "DATA DETERMINATION: DEPUTY NAMES..."
	puts "continue? [ENTER]"
	gets.chomp
	puts "please wait..."

	deputy_names = []

	doc.xpath('//*[@id="deputes-list"]/div/ul/li/a').each do |n|
		deputy_names << n.text

	deputy_names = deputy_names.map {|ve| ve.delete_prefix("M. ").to_s}
	deputy_names = deputy_names.map {|ve| ve.delete_prefix("Mme ").to_s}	
	puts deputy_names

	end

	puts "There are #{deputy_names.length} names determinated."
	puts "DEPUTY NAMES DETERMINATION: COMPLETE."
	puts "continue? [ENTER]"
	gets.chomp

	return deputy_names
end





def get_mails(deputy_url)

	puts "STEP 3"
	puts "DATA EXTRACTION: DEPUTY EMAILS..."
	puts "continue? [ENTER]"
	gets.chomp
	puts "please wait..."

	deputy_mails = []
	var = 0
	a = 1
	deputy_url[var]

	
	deputy_url.length.times do 

		page_url = deputy_url[var]
		complete_url = Nokogiri::HTML(open(page_url))
		complete_url.xpath('//dd/ul/li[2]/a').each do |email|
			begin
		  	deputy_mails << email.text

		  	puts "N°#{a} => #{email.text}"
			rescue => e 
			email = "Non renseigné"
			end

		  	var += 1
		  	a += 1

		end

	end

	puts "There are #{deputy_mails.length} emails extracted."
	puts "DEPUTY MAIL EXTRACTION: COMPLETE."
	puts "continue? [ENTER]"
	gets.chomp

	 return deputy_mails
	
end






def organize_data(deputy_names)

	deputy_mails = 4

	puts "STEP 4"
	puts "DATA ASSEMBLY: IN PROGRESS..."
	puts "continue? [ENTER]"
	gets.chomp
	puts "please wait..."

	deputy_mails = deputy_mails.join(" ")

	deputy_names = deputy_names.join(" ")

	deputy_splitnames = deputy_names.split(" ")

	deputy_firstnames = deputy_splitnames.delete_at(0)

	deputy_lastnames = deputy_splitnames.join(" ")

	deputy_aoh = [{"first_name" => deputy_firstnames, "last_name" => deputy_lastnames,"email" => deputy_mails}]

	puts deputy_aoh
	puts "There are #{deputy_aoh.length} deputy informations organized."
	puts "DEPUTY DATA EXTRACTION: COMPLETE."
	puts "continue? [ENTER]"
	gets.chomp

	return deputy_aoh

end






def perform

	doc = initialization
	abadie_mail = get_abadie_data
	deputy_url = get_urls(doc)
	deputy_names = get_names(doc)
	deputy_mails = get_mails(deputy_url)
	deputy_aoh = organize_data(deputy_names)
	
end

perform

puts "DATA RECOVERY: DEPUTY INFORMATIONS ----> DONE."

