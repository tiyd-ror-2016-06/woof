require "rails_helper"

describe Strategies::Log do
  it "writes messages to a file" do
    log_file = "./spec/files/log.txt"
    time = Time.parse "2012-02-12 12:41:32"

    s = Strategies::Log.new log_file
    message = Message.new(
      text:     "hello",
      user:     "someone",
      timestamp: time
    )

    s.call message

    expect(File.read log_file).to include "[2012/02/12 12:41:32] someone - hello"
  end
end
