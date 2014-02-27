module Blog
  class Index < HTTPServlet::AbstractServlet

    HTML = File.join(File.dirname(__FILE__), '../../public/rhtml/index.rhtml')

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
      File.open(HTML,'r') do |f|
             @template = ERB.new(f.read)
      end
      @template.result(instance_eval { binding })
    end

    def get_posts
      if @posts.empty? then Instructions.instructions_post
      else get_posts_content
      end
    end

    def get_posts_content
      content = ''
      @posts.each do |key, value|
        content << post(key, value)
      end
      content
    end

    def post(key, value)
      '<div id="' + "#{key}" + '" class="post">' +
        "#{post_form(key)}" + 
        '<h3 class="name">' + "#{value[:name]}" + '</h3>
         <h4 class="date">' + "#{value[:date]}" + '</h4>
         <p class="content">' + "#{value[:content]}" + '</p>
         </div> <!--#post-->'
    end

    def post_form(key)
      '<form action="/post" method="POST">
         <input type="hidden" name="id" value="' + "#{key}" + '"/>
         <button> <p>Edit</p> </button>
       </form>'
    end

    def sidebar_ul
      if @posts.empty? then Instructions.instructions_sidebar
      else get_posts_sidebar
      end
    end

    def get_posts_sidebar
      content = ''
      @posts.each do |key, value|
        content << '<li><a href="#' + "#{key}" + '">' + "#{value[:name]}" + '</a></li>'
      end
      content
    end
  end
end
