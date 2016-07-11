module Strategies
  class Log
    def initialize path
      @path = path
    end

    def call msg
      ts = msg.timestamp.strftime '%Y/%m/%d %H:%M:%S'
      File.write @path, "[#{ts}] #{msg.user} - #{msg.text}"
    end
  end
end
