require "./bin/app.rb"
require "test/unit"
require "rack/test"

class TestGothonweb < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  def test_my_default
    get '/'
    assert_equal(last_response.status, 302)
  end

  def test_game_form
    get '/'
    get '/game'
    assert last_response.ok?
    assert last_response.body.include?('Central Corridor')
  end

end