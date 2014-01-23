require 'sinatra'
LOG_FILE = "log.txt"

get '/hi' do
  "Hello World!"
end

get '/entrypoint' do
  File.open(LOG_FILE, "a") do |file|
    file.write("#{Time.now}: GET request to /entrypoint\n")
  end
end

post '/entrypoint' do
  File.open(LOG_FILE, "a") do |file|
    file.write("#{Time.now}: POST request to /entrypoint\n")
  end
end

get '/log' do
  IO.read(LOG_FILE)
end
