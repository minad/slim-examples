# 6-pinboard.rb
require 'sinatra'
require 'moneta'

use Rack::MonetaStore, :File, dir: 'pinboard-store'

get '/' do
  slim :index
end

post '/' do
  slim :index
end

__END__

@@ layout
html
  = yield

@@ index

  form method='post'
    fieldset
      label for='name'
      input name='name'
      label for='post'
      textarea name='post'
      input type='submit'
