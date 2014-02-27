module Blog
  class PostForm < HTTPServlet::AbstractServlet

    NEW = "New Post"
    EDIT = "Edit Post"
    CONTENT = "Content here..."
    HTML = File.join(File.dirname(__FILE__), '../../public/rhtml/post_form.rhtml')

    def do_POST(req, resp)
      resp.body = create_form(req)
      resp['Content-Type'] = 'text/html'
    end

    def do_GET(req, resp)
      resp.body = create_form(req)
      resp['Content-Type'] = 'text/html'
    end

    private
    def create_form(req)
      @id = req.query["id"]
      @post = XMLManager.select_by_id(@id) || {}
      File.open(HTML,'r') do |f|
             @template = ERB.new(f.read)
      end
      @template.result(instance_eval { binding })
    end

    def id
      @id || nil
    end

    def post_title
      @post.empty? ? NEW : EDIT
    end

    def content
      @post[:content] || CONTENT
    end
  end
end
