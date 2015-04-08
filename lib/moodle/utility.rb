module Moodle
  module Utility
    class << self
      def query_hash(function, token)
        {
          :wsfunction => function,
          :moodlewsrestformat => 'json',
          :wstoken => token
        }
      end
    end
  end
end