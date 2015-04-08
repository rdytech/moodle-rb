require 'httparty'
require 'moodle/client'
require 'moodle/courses'
require 'moodle/categories'
require 'moodle/enrolments'
require 'moodle/utility'
require 'moodle/users'
require 'moodle/version'

module Moodle
  def self.new(token, url)
    Client.new(token, url)
  end
end
