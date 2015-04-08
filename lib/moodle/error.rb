module Moodle
  class MoodleError < StandardError
    attr_reader :response_body, :code, :message

    def initialize(response_body)
      @response_body = response_body

      if response_body.is_a?(Hash)
        @code       = response_body["errorcode"]
        @message    = response_body["message"]
      else
        @message    = response_body.to_s
      end

      super(response_body.inspect)
    end
  end
end
