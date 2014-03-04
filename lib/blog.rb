require 'webrick'
require 'erb'
include WEBrick

require_relative 'blog/xml_manager'
require_relative 'blog/servlets'
require_relative 'blog/server'
require_relative 'blog/post_manager'
