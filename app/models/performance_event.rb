require 'nokogiri'
require 'open-uri'

class PerformanceEvent
  attr_accessor :theatre, :title, :date, :time, :price, :link, :tags, :poster, :description

  THREATRE_SOUTHBANK = 'Southbank'
  THEATRE_NATIONALTHEATRE = 'National Theatre'
  THEATRE_ROH = 'Royal Opera House'

  def parsed_price
    if price && price.split('-')[0] != nil
      first = (price.split('-')[0]).from(1)
      first.to_i
    else
      0
    end
  end

  def parsed_date
    date_arr = date.split(" ")
    date_string = date_arr[1] + " " + date_arr[2]
    Chronic.parse(date_string).to_date
  end

  def parsed_time
    if time != "" and time != nil
      Chronic.parse(time).hour
    end
  end

  def next_month?
    parsed_date <= Time.current.end_of_month + 1.month && parsed_date >=Time.current.end_of_month + 1.day
  end

  def self.filter_events(event_arr, params)
    # if params[:theatre] = 'national'
      event_arr = event_arr.select { |event| event.title != nil || event.title != "" }
      if params[:price] == 'up_to_20'
        event_arr = event_arr.select { |event| event.up_to_20? }
      end
      if params[:price] == 'up_to_40'
        event_arr = event_arr.select { |event| event.up_to_40? }
      end

      #when filter
      if params[:when] == 'today'
        event_arr = event_arr.select { |event| event.today? }
      end
      if params[:when] == 'this_week'
        event_arr = event_arr.select { |event| event.this_week?}
      end

      if params[:when] == 'this_month'
        event_arr = event_arr.select { |event| event.this_month? }
      end

      if params[:when] == 'next_month'
        event_arr = event_arr.select { |event| event.next_month? }
      end

      #at what time filter
      if params[:time] == 'afternoon'
        event_arr = event_arr.select { |event| event.parsed_time == nil || event.in_the_afternoon? }
      end

      if params[:time] == 'evening'
        event_arr = event_arr.select { |event| event.parsed_time == nil || event.in_the_evening? }
      end
      if params[:time] == 'morning'
        event_arr = event_arr.select { |event| event.parsed_time == nil || event.in_the_morning? }
      end

      if params[:tags]
        event_arr = event_arr.select { |event| event.tags != nil && event.tags.downcase.include?(params[:tags])}
      end
      event_arr
    end

  include EventTimeHelpers

  def up_to_20?
    parsed_price <= 20
  end

  def up_to_40?
    parsed_price <= 40
  end

  def self.tags_set(event_arr)
    tags_set = Set.new
    event_arr.each do |event|
      if event.tags != nil
        event.tags.split(', ').each do |tag|
          tags_set << tag
        end
      end
    end
    tags_set
  end
end
