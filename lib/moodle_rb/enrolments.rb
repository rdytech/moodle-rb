module MoodleRb
  class Enrolments
    include HTTParty
    include Utility

    attr_reader :token, :query_options
    STUDENT_ROLE_ID = 5

    def initialize(token, url, query_options)
      @token = token
      @query_options = query_options
      self.class.base_uri url
    end

    # required params:
    # user_id course_id
    def create(params)
      response = self.class.post(
        '/webservice/rest/server.php',
        {
          :query => query_hash('enrol_manual_enrol_users', token),
          :body => {
            :enrolments => {
              '0' => {
                :userid => params[:user_id],
                :courseid => params[:course_id],
                :roleid => STUDENT_ROLE_ID
              }
            }
          }
        }.merge(query_options)
      )
      check_for_errors(response)
      response.code == 200 && response.parsed_response.nil?
    end
  end
end
