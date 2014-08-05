# 6-pinboard.rb
require 'sinatra'
require 'slim'
require 'rack/moneta_store'

use Rack::MonetaStore, :File, dir: 'pinboard-store'

get '/' do
  store = env['rack.moneta_store']
  n = store.increment('post', 0)
  @posts = ((n-10)..n).map {|i| store[i] }.compact.reverse
  slim :index
end

post '/' do
  store = env['rack.moneta_store']
  n = store.increment('post')
  store.delete(n - 10) if n > 10
  store[n] = {name: params[:name], text: params[:text]}
  redirect '/'
end

__END__

@@ layout
doctype html
html
  head
  body
    .content == yield

@@ index
h1 Pinboard
.posts
  - @posts.each do |post|
    h2=post[:name]
    p= post[:text]
.form
  form method='post'
    fieldset
      p
        label for='name' Name:
        input name='name' autofocus=true
      p
        label for='text' Text:
        textarea name='text'
      p: input type='submit'
