require 'net/http'
require 'rtest'
require_relative 'constants'
require_relative 'blog'

include RTest::MainTest

def reset_file
  File.open(FILE, "w") { |data| data << ORIGINAL_FILE}
end

server = Blog::Server.new(PORT).server
Thread.new() { server.start }
Blog::XMLManager.set_xml(FILE)

the Blog::Index, " no post is passed" do
  has_to "ask for new information" do
    uri = URI(URI_POST_ADDRESS)
    res = Net::HTTP.get_response(uri)
    include_body = res.body.include?('<textarea id="content" name="content">Content here...</textarea>')
    include_name = res.body.include?('<input id="name" type="text" name="name" value=""/>')
    include_id = res.body.include?('<input type="hidden" name="id" value=""/>')
    correct_title = res.body.include?('<h2>New Post</h2>')
    expect(include_name).to equal(true)
    expect(include_body).to equal(true)
    expect(include_id).to equal(true)
    expect(correct_title).to equal(true)
    reset_file
  end
end

the Blog::Index, " post is passed" do
  has_to "display the post information" do
    uri = URI(URI_INDEX_ADDRESS)
    params = { name: A_NAME, content: A_CONTENT, id: NO_ID, action: SAVE }
    uri.query = URI.encode_www_form(params)
    res = Net::HTTP.get_response(uri)
    uri = URI(URI_POST_ADDRESS)
    params = { name: A_NAME, content: A_CONTENT, id: NEW_POST_ID }
    uri.query = URI.encode_www_form(params)
    res = Net::HTTP.get_response(uri)
    include_body = res.body.include?('<textarea id="content" name="content">' + "#{A_CONTENT}" + '</textarea>')
    include_name = res.body.include?('<input id="name" type="text" name="name" value="' + "#{A_NAME}" + '"/>')
    include_id = res.body.include?('<input type="hidden" name="id" value="' + "#{NEW_POST_ID}" + '"/>')
    correct_title = res.body.include?('<h2>Edit Post</h2>')
    expect(include_name).to equal(true)
    expect(include_body).to equal(true)
    expect(include_id).to equal(true)
    expect(correct_title).to equal(true)
    reset_file
  end
end

run_tests
server.shutdown
