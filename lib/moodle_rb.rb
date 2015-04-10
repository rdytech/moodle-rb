require 'httparty'
require 'moodle_rb/client'
require 'moodle_rb/courses'
require 'moodle_rb/categories'
require 'moodle_rb/enrolments'
require 'moodle_rb/error'
require 'moodle_rb/utility'
require 'moodle_rb/users'
require 'moodle_rb/version'

module MoodleRb
  def self.new(token, url)
    Client.new(token, url)
  end
end
