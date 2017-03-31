class MessagesController < ApplicationController
  def create
  end

  def new
    @message = Message.new
  end
end
