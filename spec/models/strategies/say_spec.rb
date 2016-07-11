require "rails_helper"

describe Strategies::Say do
  let(:time) { Time.parse "2012-02-12 12:41:32" }
  let(:message) {
    Message.new(
      text:     "hello",
      user:     "someone",
      timestamp: time
    )
  }

  it "says stuff" do
    s = Strategies::Say.new live: false

    s.call message

    expect(s.history).to include "someone says hello"
  end
end
