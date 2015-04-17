module MoodleRb
  class Users
    include HTTParty

    attr_reader :token

    def initialize(token, url)
      @token = token
      self.class.base_uri url
    end

    # required params:
    # username password firstname lastname email
    # optional params:
    # idnumber
    #     An arbitrary ID code number perhaps from the institution
    def create(params)
      response = self.class.post(
        '/webservice/rest/server.php',
        {
          :query => Utility.query_hash('core_user_create_users', token),
          :body => {
            :users => {
              '0' => params
            }
          }
        }
      )
      if Utility.error_response?(response)
        raise MoodleError.new(response.parsed_response)
      else
        response.parsed_response.first
      end
    end

    def show(id)
      response = self.class.post(
        '/webservice/rest/server.php',
        {
          :query => Utility.query_hash('core_user_get_users', token),
          :body => {
            :criteria => {
              '0' => {
                :key => 'id',
                :value => id
              }
            }
          }
        }
      )
      response.parsed_response['users'] && response.parsed_response['users'].first
    end

    def destroy(id)
      response = self.class.post(
        '/webservice/rest/server.php',
        {
          :query => Utility.query_hash('core_user_delete_users', token),
          :body => {
            :userids => {
              '0' => id
            }
          }
        }
      )
      response.parsed_response.nil?
    end

    def enrolled_courses(user_id)
      response = self.class.post(
        '/webservice/rest/server.php',
        {
          :query => Utility.query_hash('core_enrol_get_users_courses', token),
          :body => {
            :userid => user_id
          }
        }
      )
      response.parsed_response
    end
  end
end