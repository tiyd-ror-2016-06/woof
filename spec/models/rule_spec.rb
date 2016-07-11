require "rails_helper"

describe Rule do
  let(:log_file) { "./spec/files/log.txt" }
  let(:message) {
    Message.new(
      text:     "hello",
      user:     "someone"
    )
  }
  let(:urgent_message) {
    Message.new(
      text: "urgent: please get back to me by C.O.B.",
      user: "boss"
    )
  }
  let(:rule) {
    Rule.new(
      pattern:    "urgent",
      strategies: [Strategies::Say.new(live: false), Strategies::Log.new(log_file)]
    )
  }

  it "can check if a message matches" do
    expect(rule.applies? message).to eq false
    expect(rule.applies? urgent_message).to eq true
  end

  it "apply all the strategies to a message" do
    rule.apply_to urgent_message
    
    rule.strategies.each do |strat|
      expect(strat.history.count).to eq 1
    end
  end
end
