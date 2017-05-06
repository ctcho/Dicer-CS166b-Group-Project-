class AppearancesChannel < ApplicationCable::Channel
  def subscribed
    redis.set("user_#{current_user.id}_online", "1")
    stream_from("appearances_channel")
    ActionCable.server.broadcast "appearances_channel",
                                    user_id: current_user.id,
                                    online: true
    # stream_from "some_channel"
  end

  def unsubscribed
    redis.del("user_#{current_user.id}_online")
    ActionCable.server.broadcast "appearances_channel",
                                  user_id: current_user.id,
                                  online: false# Any cleanup needed when channel is unsubscribed
  end

  private

  def redis
    Redis.new
  end
  
end
