module Moodle
  VERSION = '0.0.2' unless defined?(self::VERSION)

  def self.version
    VERSION
  end
end
