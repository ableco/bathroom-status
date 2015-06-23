require 'sinatra'
require 'open-uri'
require 'json'

set :public_folder, Proc.new { File.join(root, "public") }

get '/' do
  @status = getStatus
  erb :index
end

get '/index.json' do
  getStatus
end


# Private

def getStatus
  json = JSON.parse(open("https://data.sparkfun.com/output/JxxL7ZLvaMSNMJyOxLYW.json").read)
  json[0]['status']
end
