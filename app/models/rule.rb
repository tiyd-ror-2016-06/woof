class Rule
  attr_reader :pattern, :strategies

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
end
