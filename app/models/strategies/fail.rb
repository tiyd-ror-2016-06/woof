module Strategies
  class Fail
    class Failure < StandardError; end

    def call msg
      raise Failure
    end
  end
end
