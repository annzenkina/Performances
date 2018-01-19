require 'nokogiri'
#require 'open-uri'
page = Nokogiri::HTML(File.read("royal_opera_house.html"))
elements = page.css(".pictureCaption")

event_arr = []
elements.each do |element|
  event = {}
  event[:title] = element.css("div h3").text
  event[:link] = 'http://www.roh.org.uk' + element.css(".headingLink")[0].attr('href')

  event[:description] = element.css(".shortBackground").text
  if element.css(".subHdr").text != nil
    event[:date] = element.css(".subHdr").text.split("|")[0]
  end
  if element.css(".fluid")[0] != nil
    event[:poster] = element.css(".fluid")[0].attr("src")
  end
  event[:tags] = element.css(".event-indicators").text
  event_arr << event
end
  puts event_arr.map {|element| element[:title] + ' ' + element[:tags]}
