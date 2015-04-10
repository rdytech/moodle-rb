module MoodleRb
  module Utility
    class << self
      def query_hash(function, token)
        {
          :wsfunction => function,
          :moodlewsrestformat => 'json',
          :wstoken => token
        }
      end

      def error_response?(response)
        response && response.parsed_response.is_a?(Hash) &&
          response.parsed_response.has_key?('exception')
      end
    end
  end
end
