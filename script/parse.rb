class SouthBankController < ApplicationController
  def index
    require 'nokogiri'

    page = Nokogiri::HTML(File.read("whatson.html"))

    elements = page.css(".views-row")

    elements.each do |element|
      title = element.css(".c-event-listing-title a.c-event-listing-title__list-view .node__title").text
      date = element.css(".c-event-listing-date.c-event-listing-date__list-view").text

      if element.css("a.c-event-listing-title__list-view")[0]
        link = element.css("a.c-event-listing-title__list-view")[0]['href']
      else
        link = '/0'
      end
      tags = element.css(".c-event-listing-tags .field__item").text
      date = ""
      date_elements = element.css(".c-event-listing-date.c-event-listing-date__list-view").children
      date_elements.each do |element|
        if element.class == Nokogiri::XML::Text
          date += " " + element.text.strip
        end
      end
  #date = element.css(".c-event-listing-title .c-event-listing-left .c-listing-image .c-event-listing-date .c-event-listing-date__list-view").text
      if title.size > 0
        puts title.strip
        puts date.strip
        puts "https://www.southbankcentre.co.uk/whats-on" + link
        if tags == ""
          puts "—"
        else
          puts tags
        end
        puts ""
      end
    end
  end
end
