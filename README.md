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
