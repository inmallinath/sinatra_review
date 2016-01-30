require "sinatra"
require "sinatra/reloader"

enable :sessions
get "/" do
  erb :index, layout: :default_layout
end

get "/new" do
  erb :add_song, layout: :default_layout
end

post "/" do
  # "Artist: #{params[:artist]}, Title: #{params[:title]}, Video: #{params[:video]}"
  # erb :add_song, layout: :default_layout
  artist = params[:artist]
  title = params[:title]
  video = params[:video]
  session[:songs] = {} unless session[:songs]
  session[:songs][artist] = {title => video}
  erb :index, layout: :default_layout
end
