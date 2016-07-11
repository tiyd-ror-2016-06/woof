class Message
  attr_reader :text, :user, :timestamp
  
  def initialize text:, user:, timestamp: Time.now
    @text, @user, @timestamp = text, user, timestamp
  end
end
