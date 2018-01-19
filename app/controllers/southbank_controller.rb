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
        link = ''
      end
      tags = element.css(".c-event-listing-tags .field__item").text
      date = ""
      date_elements = element.css(".c-event-listing-date.c-event-listing-date__list-view").children
      date_elements.each do |element|
        if element.class == Nokogiri::XML::Text
          date += " " + element.text.strip
        end
      end
      event = PerformanceEvent.new
      event.title = title.strip
      event.date = date.strip
      event.time = time.strip
      event.link = link.strip
      event.price = "–"
      # if tags == ""
      #     event.tags = "–"
      # else
      #     event.tags = event.tags = tags
      end
    end
  end
end
