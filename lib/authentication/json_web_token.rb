module Authentication
  class JsonWebToken
    class << self
      def encode(payload, secret_key, exp = 12.hours.from_now)
        payload[:exp] = exp.to_i
        JWT.encode(payload, secret_key)
      end

      def decode(token, secret_key)
        return nil if Rails.cache.exist?(token)
        decoded = JWT.decode(token, secret_key)[0]
        HashWithIndifferentAccess.new decoded
      rescue
        nil
      end

      def expire(token, secret_key)
        decoded = JWT.decode(token, secret_key)[0]
        data = HashWithIndifferentAccess.new(decoded)
        Rails.cache.write(token, data[:user_id], {expires_in: data[:exp] - Time.now.to_i}) != false
      rescue
        false
      end
    end
  end
end