require "sinatra"
require "sinatra/reloader"

get "/" do
  erb :index, layout: :default_layout
end

get "/new" do
  erb :add_song, layout: :default_layout
end
