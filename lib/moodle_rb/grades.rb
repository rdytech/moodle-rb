module MoodleRb
  class Grades
    include HTTParty
    include Utility

    attr_reader :token

    def initialize(token, url)
      @token = token
      self.class.base_uri url
    end

    def by_assignment(assignment_id)
      response = self.class.post(
        '/webservice/rest/server.php',
        {
          :query => query_hash('mod_assign_get_grades', token),
          :body => {
            :assignmentids => api_array(assignment_id)
          }
        }
      )
      if error_response?(response)
        raise MoodleError.new(response.parsed_response)
      else
        response.parsed_response['assignments']
      end
    end

    def by_course(course_id, *user_ids)
      response = self.class.post(
        '/webservice/rest/server.php',
        {
          :query => query_hash('core_grades_get_grades', token),
          :body => {
            :courseid => course_id,
            :userids => api_array(user_ids)
          }
        }
      )
      if error_response?(response)
        raise MoodleError.new(response.parsed_response)
      else
        response.parsed_response['items']
      end
    end
  end
end
