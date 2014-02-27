require 'webrick'
require 'erb'
include WEBrick

require_relative 'blog/timer'
require_relative 'blog/xml_manager'
require_relative 'blog/xml_manager_node_creator'
require_relative 'blog/xml_manager_node_selecter'
require_relative 'blog/instructions'
require_relative 'blog/index'
require_relative 'blog/post_form'
require_relative 'blog/post_manager'
require_relative 'blog/server'
