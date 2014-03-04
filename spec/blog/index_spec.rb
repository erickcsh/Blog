require 'net/http'
require 'rtest'
require_relative 'constants'
require_relative 'blog'

include RTest::MainTest

FILE = File.expand_path(File.join(File.dirname(__FILE__), '../test_index.xml'))
ORIGINAL_FILE = File.read(FILE)
URI_ADDRESS = 'http://localhost:8000/'

def reset_file
  File.open(FILE, "w") { |data| data << ORIGINAL_FILE}
end

server = Blog::Server.new.server
Thread.new() { server.start }
Blog::XMLManager.set_xml(FILE)

the Blog::Index, " create post" do
  has_to "add new post" do
    uri = URI(URI_ADDRESS)
    params = { name: A_NAME, content: A_CONTENT, id: NO_ID, action: SAVE }
    uri.query = URI.encode_www_form(params)
    res = Net::HTTP.get_response(uri)
    include_name = res.body.include?('<h3 class="name">' + "#{A_NAME}" + '</h3>')
    include_body = res.body.include?('<p class="content">' + "#{A_CONTENT}" + '</p>')
    include_sidebar = res.body.match(/<li><a href="#[0-9]*">#{Regexp.quote(A_NAME)}<\/a><\/li>/)
    expect(include_name).to equal(true)
    expect(include_body).to equal(true)
    expect(include_sidebar).not_to equal(false)
    reset_file
  end
end

the Blog::Index, " no posts included" do
  has_to "display Instructions" do
    uri = URI(URI_ADDRESS)
    res = Net::HTTP.get_response(uri)
    include_name = res.body.include?('<h3 class="name"> Instructions </h3>')
    include_body = res.body.include?('<h4 class="date"> The date goes here </h4>')
    include_sidebar = res.body.match(/<li><a href="#instructions"> Instructions <\/a><\/li>/)
    expect(include_name).to equal(true)
    expect(include_body).to equal(true)
    expect(include_sidebar).not_to equal(false)
    reset_file
  end
end

the Blog::Index, " delete post" do
  has_to "not to display the post information" do
    uri = URI(URI_ADDRESS)
    params = { name: A_NAME, content: A_CONTENT, id: NO_ID, action: SAVE }
    uri.query = URI.encode_www_form(params)
    res = Net::HTTP.get_response(uri)
    uri = URI(URI_ADDRESS)
    params = { name: A_NAME, content: A_CONTENT, id: 1, action: DELETE }
    uri.query = URI.encode_www_form(params)
    res = Net::HTTP.get_response(uri)
    include_name = res.body.include?('<h3 class="name">' + "#{A_NAME}" + '</h3>')
    include_body = res.body.include?('<p class="content">' + "#{A_CONTENT}" + '</p>')
    include_sidebar = res.body.match(/<li><a href="#[0-9]*">#{Regexp.quote(A_NAME)}<\/a><\/li>/)
    expect(include_name).not_to equal(true)
    expect(include_body).not_to equal(true)
    expect(include_sidebar).to equal(nil)
    reset_file
  end
end

the Blog::Index, " edit post" do
  has_to "display the new post information" do
    uri = URI(URI_ADDRESS)
    params = { name: A_NAME, content: A_CONTENT, id: NO_ID, action: SAVE }
    uri.query = URI.encode_www_form(params)
    res = Net::HTTP.get_response(uri)
    uri = URI(URI_ADDRESS)
    params = { name: ANOTHER_NAME, content: ANOTHER_CONTENT, id: 1, action: SAVE }
    uri.query = URI.encode_www_form(params)
    res = Net::HTTP.get_response(uri)
    include_name = res.body.include?('<h3 class="name">' + "#{ANOTHER_NAME}" + '</h3>')
    include_body = res.body.include?('<p class="content">' + "#{ANOTHER_CONTENT}" + '</p>')
    include_sidebar = res.body.match(/<li><a href="#[0-9]*">#{Regexp.quote(ANOTHER_NAME)}<\/a><\/li>/)
    expect(include_name).to equal(true)
    expect(include_body).to equal(true)
    expect(include_sidebar).not_to equal(false)
    reset_file
  end
end

run_tests
server.shutdown
