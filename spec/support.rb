#!/usr/bin/ruby

require_relative '../lib/blog'
require_relative 'blog/index_spec'
require_relative 'blog/post_form_spec'

root = './public'
test_port = 8181
address = 'localhost'

server = Blog::Server.new.server

test_server = HTTPServer.new(:Port => test_port, :BindAddress => address, :DocumentRoot => root)
test_server.mount('/index', Blog::IndexTest)
test_server.mount('/post', Blog::PostFormTest)

trap("INT") do
  server.shutdown 
  test_server.shutdown
end

Thread.new() { server.start }
Thread.new() { test_server.start }

Thread.list.each { |t| t.join() unless (t == Thread.current) }
