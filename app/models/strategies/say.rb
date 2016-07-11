module Strategies
  class Say
    attr_reader :history

    def initialize live: true
      @live, @history = live, []
    end

    def call msg
      # Slack: reqest :post, body: { ... }
      say "#{msg.user} says #{msg.text}"
    end

    private

    def say text
      if @live
        system "say '#{text}'"
      else
        @history.push text
      end
    end
  end
end
