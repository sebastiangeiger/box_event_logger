require 'sinatra'
LOG_FILE = "log.txt"

get '/log' do
  IO.read(LOG_FILE)
end

get '*' do |path|
  File.open(LOG_FILE, "a") do |file|
    file.write("#{Time.now}: GET request to #{path}\n")
  end
  "File written"
end

post '*' do |path|
  File.open(LOG_FILE, "a") do |file|
    file.write("#{Time.now}: POST request to #{path}\n")
  end
  "File written"
end
