module ApplicationCable
  class Connection < ActionCable::Connection::Base
    include SessionsHelper

    identified_by :current_user

    def connect
      self.current_user = find_verified_user
    end

    private

      def find_verified_user
        puts "finding verified user"
        if cookies.signed[:user_id] != nil
          User.find_by(id: cookies.signed[:user_id])
        else
          puts "unauthorized connection rejected"
          reject_unauthorized_connection
        end
      end
  end
end
