require 'rubygems'
require 'nokogiri'
require 'open-uri'   

PAGE_URL = "http://ruby.bastardsbook.com/files/hello-webpage.html"

# page = Nokogiri::HTML(open("index.html"))   
# puts page.class   # => Nokogiri::HTML::Document  ----> méthode si html dans pc

 page = Nokogiri::HTML(open(PAGE_URL))   
 puts page.class   # => Nokogiri::HTML::Document    ----> méthode 1 si html dans url

#page = Nokogiri::HTML(RestClient.get("http://ruby.bastardsbook.com/files/hello-webpage.html"))   
#puts page.class   # => Nokogiri::HTML::Document    ----> méthode 2 si html dans url

puts page.css("title")[0].name					  # ----> The name method simply returns the name of the element, which we already know since we specified it in the css call: "title"
puts page.css("title")[0].text                    # ----> The css method does not return the text of the target element, i.e. "My webpage". It returns an array – more specifically, a Nokogiri data object that is a collectino of Nokogiri::XML::Element objects. These Element objects have a variety of methods, including text, which does return the text contained in the element. 

links = page.css("a")
puts links.length   	# => 6
puts links[0].text   	# => Click here
puts links[0]["href"] 	# => http://www.google.com

# Here's what that first anchor tag looks like in markup form: <a href="http://www.google.com">Click here</a>

# En dessous : limiting selectors avec .select (ne pas privilégier mais fonctionne)

news_links = page.css("a").select{|link| link['data-category'] == "news"} 	#=>   http://reddit.com
news_links.each{|link| puts link['href'] } 									#=>   http://www.nytimes.com
puts news_links.class  														#=>   Array  

# En dessous : limiting selectors avec css selector (à privilégier)

news_links1 = page.css("a[data-category=news]") #=>   http://reddit.com
news_links1.each{|link| puts link['href']} 		#=>   http://www.nytimes.com
puts news_links1.class							#=>   Nokogiri::XML::NodeSet         

# The last line above demonstrates one advantage of doing the filtering with the css method and CSS selectors rather than Array.select: 
# you don't have to convert the Nokogiri NodeSet object into an Array. Keeping it as a NodeSet allows you to keep doing...well...more NodeSet-specific methods.

puts page.css('p').css("a").css("strong")
puts page.css('p').css("a strong")			# les 2 renvoient à la même chose, le 2e est plus court ---> plus simple à écrire.

# To specify elements within another element, separate the element names with a space.
"a img"			# select all image tags that are within anchor tags.
"div a img"		# select all image tags within anchor tags that themselves are within div tags.
