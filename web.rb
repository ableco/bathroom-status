require 'sinatra'
require 'open-uri'
require 'json'
require 'date'
require 'action_view'
require 'action_view/helpers'
include ActionView::Helpers::DateHelper


set :public_folder, Proc.new { File.join(root, "public") }

IMAGES = %w{champagne dogs tall ice-cream coffee oops cupcake ghost diaper vegan peace deal-with-it shhhh romantic}

get '/' do
  @status, @date = last_entry['status'], time_ago
  @image_name = IMAGES[Date.today.mday % 14]
  erb :index
end

get '/index.json' do
  "#{last_entry['status']} as of #{time_ago} ago"
end


# Private
#
def time_ago
  time_ago_in_words(Time.parse(last_entry['timestamp']), include_seconds: true)
end

def last_entry
  json = JSON.parse(open("https://data.sparkfun.com/output/JxxL7ZLvaMSNMJyOxLYW.json?limit=5").read)
  json[0]
end
