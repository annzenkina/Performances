class EventsController < ApplicationController
  before_action :load_events

  def index
    @event_arr = Event.all
  end

  def show
  end

  def load_events
    @all_events = []
    5.times do |i|
      my_event = Event.new
      if i > 2
        my_event.location = "London"
        my_event.date = 1.week.ago.to_date
      else
        my_event.location = "Ottawa"
        my_event.date = Date.today
      end
      my_event.genre = "comedy"
      my_event.title = "Sleeping Beauty " + i.to_s
      @all_events << my_event
    end

    if params[:city]
      @all_events = @all_events.select do |event|
        event.location.downcase == params[:city].downcase
      end
    end

    if params[:when].downcase == "future"
      @all_events = @all_events.select do |event|
        event.date >= Date.today
      end
    end

    if params[:when].downcase == "past"
      @all_events = @all_events.select do |event|
        event.date < Date.today
      end
    end

    # @all_events = [my_event, other_event]
  end
end
