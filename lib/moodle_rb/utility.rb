module MoodleRb
  module Utility
    def query_hash(function, token)
      {
        :wsfunction => function,
        :moodlewsrestformat => 'json',
        :wstoken => token
      }
    end

    # The Moodle API requires array arguments to be in this format
    def api_array(*array)
      {}.tap do |h|
        array.flatten.each_with_index do |x, i|
          h[i] = x
        end
      end
    end

    def error_response?(response)
      response && response.parsed_response.is_a?(Hash) &&
        response.parsed_response.has_key?('exception')
    end
  end
end
