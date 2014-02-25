module Blog
  module XMLManager
    module NodeSelecter

      def self.select_element(xml, id)
        node = nil
        xml.elements.each(POST_PATH) do |element|
          node = element if element.attributes[ID] == id.to_s
        end
        node
      end
    end
  end
end
