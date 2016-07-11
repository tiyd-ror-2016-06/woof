require "rails_helper"

describe Strategies::Log do
  let(:log_file) { "./spec/files/log.txt" }
  let(:time) { Time.parse "2012-02-12 12:41:32" }
  let(:message) {
    Message.new(
      text:     "hello",
      user:     "someone",
      timestamp: time
    )
  }

  it "writes messages to a file" do
    s = Strategies::Log.new log_file
    s.call message

    expect(File.read log_file).to include "[2012/02/12 12:41:32] someone - hello"
  end

  it "appends to the log file" do
    s = Strategies::Log.new log_file

    3.times { s.call message }

    expect(File.read(log_file).lines.count).to eq 3
  end
end
