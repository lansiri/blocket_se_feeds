ENV['RACK_ENV'] = "test"

require_relative "../app"

describe "The app" do
  include Rack::Test::Methods

  describe "start page" do
    before { get "/" }

    it "works" do
      last_response.should be_ok
      last_response.body.should include "<h1>Blocket"
    end
  end

  describe "query" do
    before { get "/stockholm?q=fisk" }

    it "works" do
      last_response.should be_ok
      last_response.headers["Content-Type"].should include "application/atom+xml"
      last_response.body.should include "<entry>"
    end
  end

  def app
    Sinatra::Application
  end
end
