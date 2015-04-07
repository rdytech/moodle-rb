require 'httparty'
require 'moodle/client'
require 'moodle/courses'
require 'moodle/categories'

module Moodle
  def self.new(token, url)
    Client.new(token, url)
  end
end
