class TheatresController < ApplicationController
  def index
    case params[:theatre]
    when nil
       #! !!if you pasting a new theatre keep in mind to add its parcer to sum
     @event_arr = EventFetcher.fetch_national + EventFetcher.fetch_southbank + EventFetcher.fetch_roh
    when "national"
      @event_arr = EventFetcher.fetch_national
    when "southbank"
      @event_arr = EventFetcher.fetch_southbank
    when "roh"
      @event_arr = EventFetcher.fetch_roh
    end
    @tags_set = PerformanceEvent.tags_set(@event_arr)
    @event_arr = PerformanceEvent.filter_events(@event_arr, params)
  end
end
