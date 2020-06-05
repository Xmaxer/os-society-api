module Authentication
  class Authentication
    class << self
      def decode_base64(string)
        begin
          decoded = Base64.strict_decode64(string).split(':')
          user_id = decoded.first
          token = decoded.last
          [user_id, token]
        rescue
          [nil, nil]
        end
      end

      def encode_base64(user)
        token = JsonWebToken.encode({user_id: user.id}, user.get_user_secret_key).to_s
        Base64.strict_encode64(user.id.to_s + ":" + token)
      end

      def get_encoded_string(user)
        encode_base64(user)
      end

      def authenticate(encoded_string)
        #TODO Only authorize if coming from frontend server, otherwise deny
        user_id, token = decode_base64(encoded_string)
        user = User.find_by(id: user_id)
        return nil unless user
        secret_key = user.get_user_secret_key
        decoded_result = JsonWebToken.decode(token, secret_key)
        return nil unless decoded_result
        user
      end

      def logout(encoded_string)
        user_id, token = decode_base64(encoded_string)
        user = User.find_by(id: user_id)
        return false unless user
        secret_key = user.get_user_secret_key
        JsonWebToken.expire(token, secret_key)
      end

      def logout_all(user)
        return false unless user
        user.change_secret_key
      end
    end
  end
end
