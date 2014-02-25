require 'rexml/document'

module Blog
  module XMLManager

    POST = 'post'
    POST_PATH = 'posts/post'
    NAME = 'name'
    CONTENT = 'content'
    DATE = 'date'
    ID = 'id'
    POSTS_FILE = File.join(File.dirname(__FILE__), '../../res/posts.xml')

    @@xml_file = POSTS_FILE

    def self.set_xml(file = POSTS_FILE)
      @@xml_file = file
    end

    def self.select_all
      xml = read_xml
      xml_to_hash(xml)
    end

    def self.select_by_id(id)
      xml = read_xml
      element = NodeSelecter.select_element(xml, id)
      element_to_hash(element) unless element.nil?
    end

    def self.add_node(name, content)
      xml = read_xml
      element = NodeCreator.create_node(xml, name, content)
      xml.root.add_element(element)
      write_xml(xml)
    end

    def self.edit_by_id(id, name, content)
      xml = read_xml
      element = NodeSelecter.select_element(xml, id)
      edit_element(element, name, content)
      write_xml(xml)
    end

    def self.delete(id)
      xml = read_xml
      element = NodeSelecter.select_element(xml, id)
      xml.root.delete_element(element)
      write_xml(xml)
    end

    private
    def self.edit_element(element, name, content)
      element.elements.each do |node|
        node.text = name if node.name == NAME
        node.text = content if node.name == CONTENT
      end
    end

    def self.write_xml(xml)
      File.open(@@xml_file, "w") { |data| data << xml } 
    end

    def self.read_xml
      file = File.new(@@xml_file).read
      REXML::Document.new file
    end

    def self.xml_to_hash(xml)
      xml_hash = {}
      xml.elements.each(POST_PATH) do |element|
        xml_hash[element.attributes[ID].to_i] = element_to_hash(element)
      end
      xml_hash
    end

    def self.element_to_hash(element)
      element_hash = {}
      element.elements.each do |node|
        element_hash[node.name.to_sym] = node.text
      end
      element_hash
    end
  end
end
