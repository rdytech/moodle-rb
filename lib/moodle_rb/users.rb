module MoodleRb
  class Users
    include HTTParty
    include Utility

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
          :query => query_hash('core_user_create_users', token),
          :body => {
            :users => {
              '0' => params
            }
          }
        }
      )
      if error_response?(response)
        raise MoodleError.new(response.parsed_response)
      else
        response.parsed_response.first
      end
    end

    def show(id)
      response = self.class.post(
        '/webservice/rest/server.php',
        {
          :query => query_hash('core_user_get_users', token),
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
          :query => query_hash('core_user_delete_users', token),
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
          :query => query_hash('core_enrol_get_users_courses', token),
          :body => {
            :userid => user_id
          }
        }
      )
      response.parsed_response
    end

    # input keys must be in the list of supported user columns to search
    # id, lastname, firstname, idnumber, username, email
    def search(params = {})
      response = self.class.post(
        '/webservice/rest/server.php',
        {
          :query => query_hash('core_user_get_users', token),
          :body => {
            :criteria => key_value_query_format(params)
          }
        }
      )
      response.parsed_response['users']
    end

    # params must include the id of the user
    # it may include any other standard user attributes:
    # username, password, firstname, lastname, email ...
    def update(params)
      response = self.class.post(
        '/webservice/rest/server.php',
        {
          :query => query_hash('core_user_update_users', token),
          :body => {
            :users => {
              '0' => params
            }
          }
        }
      )
      if error_response?(response)
        raise MoodleError.new(response.parsed_response)
      else
        response.response.code == '200'
      end
    end
  end
end
