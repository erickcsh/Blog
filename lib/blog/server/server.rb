module Blog
  class Server

    ROOT = './public'
    PORT = 8000
    ADDRESS = 'localhost'

    attr_reader :server

    def initialize
      WEBrick::HTTPUtils::DefaultMimeTypes['rhtml'] = 'text/html'
      @server = HTTPServer.new(:Port => PORT, :BindAddress => ADDRESS, :DocumentRoot => ROOT)
      mount_address
    end

    private
    def mount_address
      @server.mount('/img', HTTPServlet::FileHandler, './public/img/')
      @server.mount('/css', HTTPServlet::FileHandler, './public/css/')
      @server.mount('/action', PostManager)
      @server.mount('/post', PostForm)
      @server.mount('/', Index)
    end
  end
end
