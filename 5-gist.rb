# 5-gist.rb
require 'slim'

class Gist < Slim::Filter
  def on_html_tag(tag, attributes, content)
    return super if tag != 'gist'

    # You could also write `[:static, "<script...>"]` directly
    # but this shows also the structure of the underlying S-expressions used by Slim.
    [:html, :tag, 'script',
     [:html, :attrs,
      [:html, :attr, 'src', [:static, "http://gist.github.com/#{content[3][1][2]}.js"]]]]
  end
end

Slim::Engine.after(Slim::Parser, Gist)

Slim::Engine.set_default_options :pretty => true

puts Slim::Template.new {%{
doctype html
html
  head
    title Slim with Gist tag
  body
    gist minad/911610
}}.render
