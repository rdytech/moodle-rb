module MoodleRb
  class Categories
    include HTTParty
    include Utility

    attr_reader :token
    ROOT_CATEGORY = 0

    def initialize(token, url)
      @token = token
      self.class.base_uri url
    end

    def index
      response = self.class.get(
        '/webservice/rest/server.php',
        {
          :query => query_hash('core_course_get_categories', token)
        }
      )
      response.parsed_response
    end

    # required params:
    # name
    # optional params:
    # parent_category
    #     the parent category id inside which the new category will be created
    #     - set to nil for a root category
    # idnumber
    #     the new category external reference. must be unique
    # description
    #     the new category description
    def create(params)
      response = self.class.post(
        '/webservice/rest/server.php',
        {
          :query => query_hash('core_course_create_categories', token),
          :body => {
            :categories => {
              '0' => {
                :name => params[:name],
                :parent => (params[:parent_category] || ROOT_CATEGORY),
                :idnumber => params[:idnumber],
                :description => params[:description]
              }
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
          :query => query_hash('core_course_get_categories', token),
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
      response.parsed_response.first
    end

    def destroy(id)
      response = self.class.post(
        '/webservice/rest/server.php',
        {
          :query => query_hash('core_course_delete_categories', token),
          :body => {
            :categories => {
              '0' => {
                :id => id,
                :recursive => 1
              }
            }
          }
        }
      )
      response.parsed_response.nil?
    end
  end
end
