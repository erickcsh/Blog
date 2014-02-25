module Blog
  class Index < HTTPServlet::AbstractServlet

    def do_POST(req, resp)
      resp.body = create_index
      resp['Content-Type'] = 'text/html'
    end

    def do_GET(req, resp)
      resp.body = create_index
      resp['Content-Type'] = 'text/html'
    end

    private
    def create_index
      @posts = XMLManager.select_all
      html_body = '<!DOCTYPE html>'
      html_body << html
    end

    def html
      "<html> #{head} #{body} </html>"
    end

    def head
      '<head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <link rel="stylesheet" type="text/css" media="screen" href="css/reset.css" />
        <link rel="stylesheet" type="text/css" media="screen" href="css/styles.css" />
        <title>Pernix - Apprenticeship - Blog: Plain Ruby</title>
       </head>'
    end

    def body
      "<body> #{header} #{content_wrapper} #{footer} </body>"
    end

    def header
      '<header><h1> Blog </h1></header>'
    end

    def content_wrapper
      '<div id="content_wrapper"><div id="main_content">' +
        "#{last_posts} #{sidebar}" +
        '</div> <!--#main_content--> </div> <!--#content_wrapper-->'
    end

    def last_posts
      '<div id="last_posts">' + 
        "#{posts_intro} #{posts_options} #{posts}" + 
        '</div> <!--#last_posts-->'
    end

    def posts_intro
      '<div id="posts_intro"><div id="posts_titles"><h2> Last Posts </h2>
       </div> <!--#posts_titles--></div> <!--#posts_intro-->'
    end

    def posts_options
      '<div id="posts_options"> <div id="post_new"> <form action="/post">
       <button id="new"> <p>New</p> </button> </form>
       </div> <!--#post_new--> </div> <!--#posts_options-->'
    end

    def posts
      '<div id="posts">' + "#{get_posts}" + '</div> <!--#posts-->'
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

    def sidebar
      '<div class="sidebar"><div id="post_selector"><h5> All Posts </h5> <ul>' +
        "#{sidebar_ul}" + '</ul></div></div> <!--#sidebar-->'
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

    def footer
      '<footer></footer>'
    end
  end
end
