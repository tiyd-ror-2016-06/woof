require "rails_helper"

describe Strategies::Fail do
  it "fails when given a message" do
    s = Strategies::Fail.new
    message = Message.new(
      text:     "hello",
      user:     "someone",
      timestamp: Time.now
    )

    expect { s.call message }.to raise_error(Strategies::Fail::Failure)
  end
end
