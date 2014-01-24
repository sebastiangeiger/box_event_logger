ENV['RACK_ENV'] = 'test'

require_relative '../app'
require 'rspec'
require 'rack/test'
require 'pry'

describe 'My App' do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  describe 'GET /log' do
    it 'serves the log.txt' do
      log_contents = IO.read("log.txt")
      get '/log'
      expect(last_response).to be_ok
      expect(last_response.body).to eql log_contents
    end
  end

  describe 'GET /entrypoint' do
    it 'returns status 200' do
      get '/entrypoint'
      expect(last_response).to be_ok
    end
    it 'appends to log file' do
      old_size = IO.read("log.txt").split("\n").size
      get '/entrypoint'
      new_size = IO.read("log.txt").split("\n").size
      expect(new_size).to eql(old_size + 1)
    end
  end

  describe 'my catch all route' do
    it 'appends to log file when I call GET /a' do
      old_size = IO.read("log.txt").split("\n").size
      get '/a'
      new_size = IO.read("log.txt").split("\n").size
      expect(new_size).to eql(old_size + 1)
    end
    it 'appends to log file when I call GET /b' do
      old_size = IO.read("log.txt").split("\n").size
      get '/b'
      new_size = IO.read("log.txt").split("\n").size
      expect(new_size).to eql(old_size + 1)
    end
    it 'appends the right text to the log file when I call GET /b' do
      get '/b'
      current_line = IO.read("log.txt").split("\n").last
      expect(current_line).to include ('GET request to /b')
    end
    it 'appends the right text to the log file when I call POST /c' do
      post '/c'
      current_line = IO.read("log.txt").split("\n").last
      expect(current_line).to include ('POST request to /c')
    end
  end
end
