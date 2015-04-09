module Moodle
  VERSION = '0.0.4' unless defined?(self::VERSION)

  def self.version
    VERSION
  end
end
