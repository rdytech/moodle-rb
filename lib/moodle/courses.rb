class Courses
  include HTTParty

  attr_reader :token

  def initialize(token, url)
    @token = token
    self.class.base_uri url
  end

  def index
    response = self.class.get(
      '/webservice/rest/server.php',
      {
        :query => {
          :wsfunction => 'core_course_get_courses',
          :moodlewsrestformat => 'json',
          :wstoken => token
        }
      }
    )
    response.parsed_response
  end

  # required params:
  # full_name, short_name
  # parent_category
  #   the parent category id inside which the new category will be created
  # optional params:
  # idnumber
  #     the new course external reference
  def create(params)
    response = self.class.post(
      '/webservice/rest/server.php',
      {
        :query => {
          :wsfunction => 'core_course_create_courses',
          :moodlewsrestformat => 'json',
          :wstoken => token
        },
        :body => {
          :courses => {
            '0' => {
              :fullname => params[:full_name],
              :shortname => params[:short_name],
              :categoryid => params[:parent_category],
              :idnumber => params[:idnumber]
            }
          }
        }
      }
    )
    response.parsed_response.first
  end

  def show(id)
    response = self.class.post(
      '/webservice/rest/server.php',
      {
        :query => {
          :wsfunction => 'core_course_get_courses',
          :moodlewsrestformat => 'json',
          :wstoken => token
        },
        :body => {
          :options => {
            :ids => {
              '0' => id
            }
          }
        }
      }
    )
    response.parsed_response.first
  end
end
