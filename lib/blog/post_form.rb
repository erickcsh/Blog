module Blog
  class PostForm < HTTPServlet::AbstractServlet

    NEW = "New Post"
    EDIT = "Edit Post"
    CONTENT = "Content here..."

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
        <link rel="stylesheet" type="text/css" media="screen" href="css/form_styles.css" />
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
      '<div id="content_wrapper"><div id="main_content"><div id="main_wrapper">
       <div id="form_wrapper">' + "#{form}" +
       '</div> <!--#form_wrapper--> </div> <!--#main_wrapper-->
       </div> <!--#main_content--> </div> <!--#content_wrapper-->'
    end

    def form
      '<form method="POST" action="/">
         <input type="hidden" name="id" value="' + "#{id}" + '"/>
         <h2>' + "#{post_title}" + '</h2>' +
         "#{form_options} #{form_name} #{form_content}" +
      '</form>'
    end

    def id
      @id || nil
    end

    def post_title
      @post.empty? ? NEW : EDIT
    end

    def form_options
      '<div id="form_options">
         <input type="submit" name="action" value="Cancel"/>
         <input type="submit" name="action" value="Delete"/>
         <input type="submit" name="action" value="Save"/>
       </div> <!--#form_options-->'
    end

    def form_name
      '<div id="form_name">
        <h5> Name: </h5> <input id="name" type="text" name="name" value="' + "#{@post[:name]}" + '"/>
      </div> <!--#form_name-->'
    end

    def form_content
      '<div id="form_content">
        <textarea id="content" name="content">' + "#{content}" + '</textarea>
      </div> <!--#form_content-->'
    end

    def content
      @post[:content] || CONTENT
    end

    def footer
      '<footer></footer>'
    end
  end
end
