module Strategies
  class Log
    def initialize path
      @path = path
      @file = File.open path, "w"
    end

    def call msg
      ts = msg.timestamp.strftime '%Y/%m/%d %H:%M:%S'
      @file.puts "[#{ts}] #{msg.user} - #{msg.text}"
      @file.flush
    end

    def history
      File.read(@path).split("\n")
    end
  end
end
