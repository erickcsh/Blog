module Blog
  module XMLManager
    module NodeSelecter

      def self.select_element(xml, id)
        node = nil
        id = id.to_s
        xml.elements.each(POST_PATH) do |element|
          node = element if element.attributes[ID].to_s == id
        end
        node
      end
    end
  end
end
