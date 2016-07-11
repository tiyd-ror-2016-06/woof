class Rule
  attr_reader :pattern, :strategies

  def self.build word, handlers
    strategies = handlers.map { |sym| Handlers.fetch(sym) }
    Rule.new pattern: word, strategies: strategies
  end

  def initialize pattern:, strategies:
    @pattern, @strategies = pattern, strategies
  end

  def applies? msg
    msg.text.include? @pattern
  end

  def apply_to msg
    if applies? msg
      @strategies.each do |strat|
        strat.call msg
      end
    end
  end

  def to_s
    "#{@pattern} => #{@strategies}"
  end
end
