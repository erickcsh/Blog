module Blog
  module XMLManager
    module NodeCreator

      def self.create_node(xml, name, content)
        element = create_element_with_id(new_id(xml))
        time = Timer.get_time
        add_childs(element, name, content, time)
        element
      end

      private
      def self.create_element_with_id(id)
        element = REXML::Element.new(POST)
        element.add_attribute(ID, id)
        element
      end

      def self.add_childs(parent, name, content, time)
        [[NAME, name], [CONTENT, content], [DATE, time]].each do |tag, value|
          element = REXML::Element.new(tag)
          element.text = value
          parent.add_element(element)
        end
      end

      def self.new_id(xml)
        last_id(xml) + 1
      end

      def self.last_id(xml)
        last_id = 0
        xml.elements.each(POST_PATH) do |element|
          element_id = element.attributes[ID].to_i
          last_id = element_id if element_id > last_id
        end
        last_id
      end
    end
  end
end
