module Moodle
  VERSION = '0.0.3' unless defined?(self::VERSION)

  def self.version
    VERSION
  end
end
