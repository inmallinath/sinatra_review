# Sinatra Reveiw

> Let's have a review of Sinatra, We covered some  web concepts like HTTP verbs, including GET and POST. Let's continue with the same concepts by creating a member signup. Take a moment to think about what we will need, and how should implement it.

As per convention, let's start with a simple "hello world", to make sure we're set up correctly, then incrementally build our idea.

```Ruby
# songer.rb
require "sinatra"
require "sinatra/reloader"

get "/" do
  "<h1>Hello World!</h1>"
end

get "/songs" do

end
```
We can then run our app on port 4567 by default, or whichever port open we specify. For example, if we want our app to  be available on port 3000 of our localhost, we can run the following:
```Ruby
ruby songer.rb -p 30000
```
Now that we are satisfied that we have our machine set up correctly, we can start to develop our task.

Sinatra is expecting a directory named "views" to exist, if you are using html or erb pages. Erb is a way to add ruby code  directly into HTML pages.

Let's make that folder, and add in an index and a form to add songs.
```
mkdir views
touch views/index.erb
touch views/add_song.erb
```
To make sure we have everything working, before spending too much time developing, let's just add some text, and endpoints to each of these views one at a time.
```Ruby
# songer.rb
require "sinatra"
require "sinatra/reloader"

get "/" do
    erb :index
end

get "/new" do
  erb :add_song
end
```
Add some html to your `views/index.erb` file
```html
<h1> Hello! </h1>
```

Do the same thing for our add song form.
```erb
<!-- views/add_song.erb -->
<form>
  <input><br>
  <input><br>
  <input><br>
  <input type="submit">
</form>
```
Now that we have multiple pages (even though we only have 2), let's add some navigation. We want all pages going forward to share the same navigation, so it's easier to maintain. We can add a shared layout file.
```
touch views/default_layout.erb
```
```erb
<% # views/default_layout.erb%>
<!DOCTYPE html>
<nav><a href="/">home</a> | <a href="/new">add song</a></nav>
<%=yield%>
```
Now that we have a default layout with navigation, let's modify our `songer.rb` to use it.
```ruby
# songer.rb

get "/" do
  erb :index, layout: :default_layout
end

get "/new" do

  erb :add_song, layout: :default_layout
end
```
Let's add some functionality so we can submit input to our form, and save it in a songs key-value store in a session.

Let's start by enabling sessions. To do so, simply add `enable :sessions` to our `songer.rb` file.

```ruby
#songer.rb

require "sinatra"
require "sinatra/reloader"

enable :sessions

get "/" do
  erb :index, layout: :default_layout
end

get "/new" do
  erb :add_song, layout: :default_layout
end
```
Let's revisit our form, and make sure it's doing what we want it to. We want it to use it to submit
form data and pass a key-value store called params to our `songer.rb`.
```erb
<% # views/add_song.erb %>
<h1>Add Song<h1>
<form method="POST" action="/">
  Artist: <input name ="artist"><br>
  Title: <input name ="title"><br>
  Video: <input name ="video"><br>
  <input type = "submit"><br>
</form>

```
Now that we have a params hash available to us, let's redirect back to our index, and (for now) display the params, if there are any.

```ruby
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
  artist = params[:artist]
  title = params[:title]
  video = params[:video]
  session[:songs] = {} unless session[:songs]
  session[:songs][artist] = {title => video}
  erb :index, layout: :default_layout
end
```
Things are going pretty good, so far! Let's go for a home run by storing the params data in a songs hash in the session.
We can then use the sessions hash to populate the data.

Now that we have the data available through our session, let's use it to fill out a table on our index page that
looks something like this:

|artist|title|
|------|-----|
|Bryan Adams|[Summer of 69](https://www.youtube.com/watch?v=9f06QZCVUHg)|
