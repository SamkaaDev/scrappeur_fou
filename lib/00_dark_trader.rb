require 'rubygems'
require 'nokogiri'
require 'open-uri'   




def initialization

	puts " ----> START <----"
	puts "please wait..."
	page_url = "https://coinmarketcap.com/all/views/all/"
	puts "https://coinmarketcap.com/all/views/all/"
	doc = Nokogiri::HTML(open(page_url))
	puts "INITIALIZATION: #{doc.class}"
	puts "PRESS [ENTER]"
	gets.chomp
	puts doc
	puts " INITIALIZATION: COMPLETE."
	puts " DATA RECOVERY: CRYPTOCURRENCY PRICES."
	puts "continue? [ENTER]"
	gets.chomp

	return doc

end






def take_html_names(doc)

	puts "STEP 1 (1/2)"
	puts "EXTRACT DATA FROM HTML: CRYPTO NAMES..."
	puts "continue? [ENTER]"
	gets.chomp
	puts "please wait..."

	crypto_n = []

	doc.xpath('//*[@class = "text-left col-symbol"]').each do |n|
		crypto_n << n.text

	end

	puts crypto_n

	puts "CRYPTO NAMES EXTRACTION: COMPLETE."
	puts "There are #{crypto_n.length} cryptocurrency names extracted."
	puts "continue? [ENTER]"
	gets.chomp

	return crypto_n

end






def take_html_values(doc)

	puts "STEP 1 (2/2)"
	puts "EXTRACT DATA FROM HTML: CRYPTO VALUES..."
	puts "continue? [ENTER]"
	gets.chomp
	puts "please wait..."

	crypto_v = []

	doc.xpath('//*[@class = "price"]').each do |v|
		crypto_v << v.text

	end

	crypto_v = crypto_v.map {|ve| ve.delete_prefix("$").to_f}
	puts crypto_v

	puts "CRYPTO VALUES EXTRACTION: COMPLETE."
	puts "There are #{crypto_v.length} cryptocurrency values extracted."
	puts "continue? [ENTER]"
	gets.chomp

	return crypto_v

end






def create_hash(crypto_n, crypto_v)

	puts "STEP 2"
	puts "DATA ASSEMBLY: IN PROGRESS..."
	puts "continue? [ENTER]"
	gets.chomp
	puts "please wait..."

	crypto_h = crypto_n.zip(crypto_v).to_h

	puts crypto_h
	puts "DATA ASSEMBLY: COMPLETE."
	puts "continue? [ENTER]"
	gets.chomp

	return crypto_h

end






def organize_hash(crypto_n, crypto_v)
	
	puts "STEP 3"
	puts "DATA ARRANGEMENT: IN PROGRESS..."
	puts "continue? [ENTER]"
	gets.chomp
	puts "please wait..."

	crypto_a = crypto_n.zip(crypto_v)
	puts crypto_a
	puts "DATA ARRANGEMENT: 50%"
	puts "continue? [ENTER]"
	gets.chomp
	array_of_h = []
	crypto_a.each { |each| array_of_h << { each[0] => each[1]} }

	puts array_of_h
	puts "DATA ARRANGEMENT: COMPLETE."
	puts "continue? [ENTER]"
	gets.chomp

	return array_of_h

end





def perform

doc = initialization
crypto_n = take_html_names(doc)
crypto_v = take_html_values(doc)
crypto_h = create_hash(crypto_n, crypto_v)
array_of_h = organize_hash(crypto_n, crypto_v)
	
end

perform

puts "DATA RECOVERY: CRYPTOCURRENCY PRICES ----> DONE."



	



