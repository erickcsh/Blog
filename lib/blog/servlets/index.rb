module Blog
  class Index < HTTPServlet::AbstractServlet

    HTML = File.join(File.dirname(__FILE__), '../../../public/rhtml/index.rhtml')
    INSTRUCTIONS_POST = File.join(File.dirname(__FILE__), '../../../public/rhtml/instructions_post.rhtml')
    INSTRUCTIONS_SIDEBAR = File.join(File.dirname(__FILE__), '../../../public/rhtml/instructions_sidebar.rhtml')
    POST = File.join(File.dirname(__FILE__), '../../../public/rhtml/post.rhtml')
    POSTS_SIDEBAR = File.join(File.dirname(__FILE__), '../../../public/rhtml/posts_sidebar.rhtml')

    def do_POST(req, resp)
      resp.body = create_index(req)
      resp['Content-Type'] = 'text/html'
    end

    def do_GET(req, resp)
      resp.body = create_index(req)
      resp['Content-Type'] = 'text/html'
    end

    private
    def create_index(req)
      PostManager.process_action(req)
      @posts = XMLManager.select_all
      body_template.result(instance_eval { binding })
    end

    def get_posts
      if @posts.empty? then instructions_post_template.result(instance_eval { binding })
      else get_posts_content
      end
    end

    def get_posts_content
      content = ''
      @posts.each {|key, value| content << post_template.result(instance_eval { binding }) }
      content
    end

    def sidebar_ul
      if @posts.empty? then instructions_sidebar_template.result(instance_eval { binding })
      else get_posts_sidebar
      end
    end

    def get_posts_sidebar
      content = ''
      @posts.each {|key, value| content << posts_sidebar_template.result(instance_eval { binding }) }
      content
    end

    def body_template
      @body_template ||= read_rhtml(HTML)
    end

    def instructions_post_template
      @instructions_post_template ||= read_rhtml(INSTRUCTIONS_POST)
    end

    def instructions_sidebar_template
      @instructions_sidebar_template ||= read_rhtml(INSTRUCTIONS_SIDEBAR)
    end

    def post_template
      @post_template ||= read_rhtml(POST)
    end

    def posts_sidebar_template
      @posts_sidebar_template ||= read_rhtml(POSTS_SIDEBAR)
    end

    def read_rhtml(file)
      template = nil
      File.open(file,'r') { |f| template = ERB.new(f.read) }
      template
    end
  end
end
