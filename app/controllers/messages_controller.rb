Messages = []

class MessagesController < ApplicationController
  def index
    @rules    = RuleSet
    @messages = Messages
  end

  def create
    message = Message.new(
      user: "hardcoded user",
      text: params[:message]
    )
    Messages.push message
    RuleSet.each do |rule|
      rule.apply_to message
    end
    redirect_back fallback_location: root_path
  end
end
