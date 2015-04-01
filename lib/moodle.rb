require 'httparty'
require 'moodle/client'
require 'moodle/courses'

module Moodle
  def self.new(token, url)
    Client.new(token, url)
  end
end
