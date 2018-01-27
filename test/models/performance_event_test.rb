require 'test_helper'

class PerformanceEventTest < ActiveSupport::TestCase
  test "parsed_price unusual price format" do
    input = []
    event_price = PerformanceEvent.new
    event_price.price = ""
    input << event_price

    output = PerformanceEvent.filter_events(input, {price: "up_to_20" })

    assert_includes(output, event_price)
  end

  test "parsed_date returns date string" do
    event = PerformanceEvent.new
    event.date = "Tuesday 02 January 2018"
    parsed_date = event.parsed_date
    assert_equal("2018-01-02", parsed_date.to_s)
  end

  test "filter_events with price up to 20" do
    input = []

    expensive_event = PerformanceEvent.new
    expensive_event.price = "£30"
    input << expensive_event

    cheap_event = PerformanceEvent.new
    cheap_event.price = "£19"
    input << cheap_event

    output = PerformanceEvent.filter_events(input, { price: "up_to_20" })

    assert_includes(output, cheap_event)
    refute_includes(output, expensive_event)
  end

  test "filter_events with time" do
    input = []

    morning_event = PerformanceEvent.new
    morning_event.time = "8am"
    input << morning_event

    evening_event = PerformanceEvent.new
    evening_event.time = "8pm"
    input << evening_event

    output = PerformanceEvent.filter_events(input, {time: "morning"})

    assert_includes(output, morning_event)
    refute_includes(output, evening_event)

    output = PerformanceEvent.filter_events(input, {time: "evening"})

    assert_includes(output, evening_event)
    refute_includes(output, morning_event)
  end

  test "filter_events with time in the night" do
    input = []

    night_event = PerformanceEvent.new
    morning_event = PerformanceEvent.new
    morning_event.time = "2am"
    night_event.time = "7pm"
    input << night_event
    input << morning_event

    output = PerformanceEvent.filter_events(input, {time: "morning"})
    refute_includes(output, night_event)
    assert_includes(output, morning_event)
  end

  test "filter_events with time in the afternoon" do
    input = []

    afternoon = PerformanceEvent.new
    afternoon.time = "2pm"
    input << afternoon

    output = PerformanceEvent.filter_events(input, { time: "afternoon" })
    assert_includes(output, afternoon)
  end

  test "filter_events tags=Dance" do
    input = []
    event_dance = PerformanceEvent.new
    event_dance.tags = "Dance"
    input << event_dance

    output = PerformanceEvent.filter_events(input, { tags: "Dance" })

    assert_includes(output, event_dance)
  end

  test "filter_events tags=dance" do
    input = []
    event_dance = PerformanceEvent.new
    event_dance.tags = "Dance"
    input << event_dance

    output = PerformanceEvent.filter_events(input, { tags: "dance" })

    assert_includes(output, event_dance)
  end

  test "filter_events with price up to 40" do
    input = []

    expensive_event = PerformanceEvent.new
    expensive_event.price = "£30"
    input << expensive_event

    output = PerformanceEvent.filter_events(input, { price: "up_to_40" })

    assert_includes(output, expensive_event)
  end

  test "filter_events with params when=today" do
    input = []
    event = PerformanceEvent.new
    event.date = Date.current.strftime("%A %d %B %Y")
    input << event

    output = PerformanceEvent.filter_events(input, { when: "today" })
    assert_includes(output, event)
  end

  test "filter_events with params when=this_week" do
    input = []
    event = PerformanceEvent.new
    event.date = "Saturday 27 January 2018"
    input << event

    output = PerformanceEvent.filter_events(input, { when: "this_week"})

    assert_includes(output, event)
  end

  test "filter_events with params when=this_month" do
    input = []
    event = PerformanceEvent.new
    event.date = "Saturday 02 January 2018"
    input << event

    output = PerformanceEvent.filter_events(input, { when: "this_month"})

    assert_includes(output, event)
  end

  test "filter_events with params when=next_month" do
    input = []
    event = PerformanceEvent.new
    event.date = "Saturday 27 February 2018"
    input << event

    output = PerformanceEvent.filter_events(input, { when: "next_month"})

    assert_includes(output, event)
  end
end
