require 'test_helper'

class GeneralIntegrationTest < ActionDispatch::IntegrationTest
  ["national", "roh", "southbank"].each do |theatre|
    test "#{theatre} events" do
      get "/theatres/#{theatre}"

      elements = css_select("h2.event-title")
      assert elements.size > 10
    end
  end

  test "index page" do
    get "/"
    assert_response :success
  end
end
