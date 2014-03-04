module Blog
  module PostManager

    SAVE = "Save"
    DELETE = "Delete"
    CANCEL = "Cancel"

    def self.process_action(req)
      action = req.query["action"]
      return 400 if action.nil? || action == (CANCEL)
      save(req) if action == (SAVE)
      drop(req) if action == (DELETE)
    end

    private
    def self.save(req)
      id = req.query["id"]
      if(id_empty?(id)) then new(req)
      else edit(id, req)
      end
    end

    def self.new(req)
      name, content = post_contents(req)
      XMLManager.add_node(name, content)
    end

    def self.edit(id, req)
      name, content = post_contents(req)
      XMLManager.edit_by_id(id, name, content)
    end

    def self.post_contents(req)
      name = req.query["name"]
      content = req.query["content"]
      return name, content
    end

    def self.drop(req)
      XMLManager.delete(req.query["id"])
    end

    private
    def self.id_empty?(id)
      id == "" || id.nil?
    end
  end
end
