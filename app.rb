require 'sinatra'
LOG_FILE = "log.txt"

get '/log' do
  lines = IO.read(LOG_FILE).split("\n").map do |line|
    "<li>#{line}</li>"
  end.join("\n")
  "<h1>Access Log</h1><ol>#{lines}</ol>"
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
