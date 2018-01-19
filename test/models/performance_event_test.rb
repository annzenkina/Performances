require 'test_helper'

class PerformanceEventTest < ActiveSupport::TestCase
  # test "basic attributes" do
  #   event = PerformanceEvent.new
  #   event.link = "/mylink"
  #
  #   assert_equal "expected", event.full_link
  # end
  #
  # test "fetch_all" do
  #   events = PerformanceEvent.fetch_all
  #   assert_equal 5, events.size
  #
  #   assert_equal "Backstage Tour", events[0].title
  # end

  test "filter_events with price up to 20" do
    input = []

    expensive_event = PerformanceEvent.new
    expensive_event.price = "£30"
    input << expensive_event

    cheap_event = PerformanceEvent.new
    cheap_event.price = "£19"
    input << cheap_event

    output = PerformanceEvent.filter_events(input, { price: "up_to_20" })

    assert output.include?(cheap_event)
    assert !output.include?(expensive_event)

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

    assert output.include?(morning_event)
    assert !output.include?(evening_event)

    output = PerformanceEvent.filter_events(input, {time: "evening"})

    assert output.include?(evening_event)
    assert !output.include?(morning_event)
  end

  test "filter_events with time in the night" do
    input = []

    night_event = PerformanceEvent.new
    morning_event.time = "2am"
    input << night_event

    output = PerformanceEvent.filter_events(input, {time: "morning"})
    assert output.include?(evening_event)
    assert !output.include?(morning_event)
  end
end
