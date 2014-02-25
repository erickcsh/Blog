require "blog"
require "constants"
    
file = File.expand_path(File.join(File.dirname(__FILE__), '/spec/test.xml'))
original_file = File.read(file)

def reset_file(file, content)
  File.open(file, "w") { |data| data << content } 
end

the Blog::XMLManager, ".select_all" do
  has_to "read all the xml" do
    Blog::XMLManager.set_xml(file)
    cols = Blog::XMLManager.select_all
    expect(cols).to equal(ALL_POSTS)
    reset_file(file, original_file)
  end
end

the Blog::XMLManager, ".select_by_id" do
  has_to "select the correct node" do
    Blog::XMLManager.set_xml(file)
    cols = Blog::XMLManager.select_by_id(POST_ID)
    expect(cols).to equal(CONTENT_POST_ID)
    reset_file(file, original_file)
  end
end

the Blog::XMLManager, ".add_node" do
  has_to "add the node to the file" do
    Blog::XMLManager.set_xml(file)
    Blog::XMLManager.add_node(A_NAME, A_CONTENT)
    cols = Blog::XMLManager.select_by_id(NEW_ID)
    expect(cols[:name]).to equal(A_NAME)
    expect(cols[:content]).to equal(A_CONTENT)
    reset_file(file, original_file)
  end
end

the Blog::XMLManager, ".edit_by_id" do
  has_to "edit the node on the file" do
    Blog::XMLManager.set_xml(file)
    Blog::XMLManager.edit_by_id(POST_ID, A_NAME, A_CONTENT)
    cols = Blog::XMLManager.select_by_id(POST_ID)
    expect(cols[:name]).to equal(A_NAME)
    expect(cols[:content]).to equal(A_CONTENT)
    reset_file(file, original_file)
  end
end

the Blog::XMLManager, ".delete" do
  has_to "delete the node on the file" do
    Blog::XMLManager.set_xml(file)
    Blog::XMLManager.delete(POST_ID)
    cols = Blog::XMLManager.select_by_id(POST_ID)
    expect(cols).to equal(nil)
    reset_file(file, original_file)
  end
end
