require 'sinatra'
require 'open-uri'
require 'json'
require 'action_view'
require 'action_view/helpers'
include ActionView::Helpers::DateHelper


set :public_folder, Proc.new { File.join(root, "public") }

get '/' do
  @status, @date = last_entry['status'], time_ago
  erb :index
end

get '/index.json' do
  "#{last_entry['status']} as of #{time_ago} ago"
end


# Private
#
def time_ago
  time_ago_in_words(Time.parse(last_entry['timestamp']))
end

def last_entry
  json = JSON.parse(open("https://data.sparkfun.com/output/JxxL7ZLvaMSNMJyOxLYW.json").read)
  json[0]
end
