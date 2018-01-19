module EventFetcher
  def self.fetch_national
    theatre_link = "https://www.nationaltheatre.org.uk"
    # page = Nokogiri::HTML(open("https://www.nationaltheatre.org.uk/whats-on/results?what=at_the_NT%2CNT_Other_Venues%2CNT_Events&when=next%20300"))
    page = Nokogiri::HTML(File.read("national.html"))

    elements = page.css(".row.brighter-main-bg-color.production")

    event_arr = []
    elements.each do |element|
      title = element.css(".c-m-8.c-xs-15.production-header .h3 a").text
      date = element.css(".c-m2-2.c-xs-15.pad-all .date").text
      time = element.css(".c-m2-2.c-xs-15.pad-all .time").text
      link = element.css(".float-right.c-m2-2.c-xs2-4.pad-all a")[0].attr("href")
      poster = element.css(".c-m2-2.c-xs2-4.production-image img")[0].attr("src")
      #description = element.css(".field.field--name-field-teaser.field--type-text-long.field--label-hidden").text

      price = ""
      element.css(".c-m2-2.c-xs2-4.btn.alt-dark .margin-top-half.gray-dark p").each do |ticket_price|
        price += ticket_price.text + "\n"
      end

      event = PerformanceEvent.new
      event.theatre = THEATRE_NATIONALTHEATRE
      event.title = title.strip
      event.date = date.sub("Various times","")
      event.time = time.strip
      if price.strip == ""
        event.price = nil
      else
        event.price = price.strip
      end
      event.poster = theatre_link + poster
      event.link = "https://www.nationaltheatre.org.uk/whats-on" + link.strip
  #    event.description = description
        event_arr << event
    end
    event_arr
  end

  def self.fetch_southbank
    #page = Nokogiri::HTML(open("https://www.southbankcentre.co.uk/whats-on?page=5"))
    page = Nokogiri::HTML(File.read("southbank_page_5.html"))

    elements = page.css(".views-row")

    event_arr = []
    elements.each do |element|
      title = element.css(".c-event-listing-title a.c-event-listing-title__list-view .node__title").text
      #date = element.css(".c-event-listing-date.c-event-listing-date__list-view").text
      if element.css("a.c-event-listing-left__image .field__item img")[0]
        poster = element.css("a.c-event-listing-left__image .field__item img")[0]['src']
      else
        poster =''
      end

      if element.css("a.c-event-listing-title__list-view")[0]
        link = element.css("a.c-event-listing-title__list-view")[0]['href']
      else
        link = ''
      end

      description = element.css(".field.field--name-field-teaser.field--type-text-long.field--label-hidden").text

      tags_css = element.css(".c-event-listing-tags .field__items .even")
      if tags_css.size > 0
        tags = tags_css.text.strip
      else
        tags = nil
      end
      date_elements = element.css(".c-event-listing-date.c-event-listing-date__list-view").children

      date = ""
      date_elements.each do |element|
        if element.class == Nokogiri::XML::Text
          date += " " + element.text.strip
        end
      end

      event = PerformanceEvent.new
      event.title = title.strip
      event.date = date.sub("Various times","")
#      event.time = time.strip
      event.link = "https://www.southbankcentre.co.uk/whats-on" + link.strip
      event.tags = tags
      event.price = ""
      event.poster = poster
      event.description = description.strip
      event.theatre = THREATRE_SOUTHBANK
      if (title != nil) && (title.strip != "")
        event_arr << event
      end
    end
    event_arr
  end

  def self.fetch_roh
    theatre_link = "http://www.roh.org.uk"
    page = Nokogiri::HTML(File.read("royal_opera_house.html"))
    elements = page.css(".pictureCaption")

    event_arr = []
    elements.each do |element|
      title = element.css("div h3").text
      link = theatre_link + element.css(".headingLink")[0].attr('href')

      description = element.css(".shortBackground").text
      if element.css(".subHdr").text != nil
        date = element.css(".subHdr").text.split("|")[0]
      end
      if element.css(".fluid")[0] != nil
        poster = element.css(".fluid")[0].attr("src")
      end
      tags = ''
      if element.css(".event-indicators").text != ''
        element.css(".event-indicators li").each do |tag|
          tags += tag.text + ', '
        end
        tags = tags.chomp(', ').strip
      else
        tags = nil
      end
      event = PerformanceEvent.new
      event.title = title.strip
      date_time = date.strip
      event.date = date_time.split(',')[0]
      event.time = date_time.split(',')[1]
      event.link = link.strip
      event.price = ""
      event.poster = poster
      event.description = description
      event.tags = tags
      event.theatre = THEATRE_ROH
      if (title != nil) && (title.strip != "")
        event_arr << event
      end
    end
    event_arr
  end
end
