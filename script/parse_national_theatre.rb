class NationalController < ApplicationController
  def index
    require 'nokogiri'

    page = Nokogiri::HTML(File.read("national_watson.html"))

    elements = page.css(".row.brighter-main-bg-color.production").first(5)

    @event_arr = []
    elements.each do |element|
      title = element.css(".c-m-8.c-xs-15.production-header .h3 a").text
      date = element.css(".c-m2-2.c-xs-15.pad-all .date").text
      time = element.css(".c-m2-2.c-xs-15.pad-all .time").text
      link = element.css(".float-right.c-m2-2.c-xs2-4.pad-all a")[0].attr("href")

      price = ""
      element.css(".c-m2-2.c-xs2-4.btn.alt-dark .margin-top-half.gray-dark p").each do |ticket_price|
        price += ticket_price.text + "\n"
      end

      event = PerfomanceEvent.new
      event.title = title.strip
      event.date = date.strip
      event.time = time.strip
      event.price = price.strip
      event.link = link.strip

      @event_arr << event
    end
  end
end
