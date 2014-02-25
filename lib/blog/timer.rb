module Blog
  module Timer

    def self.get_time
      time = Time.new
      time.strftime("%Y-%m-%d %H:%M:%S")
    end
  end
end
