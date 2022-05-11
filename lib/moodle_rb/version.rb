module MoodleRb
  VERSION = '2.1.0' unless defined?(self::VERSION)

  def self.version
    VERSION
  end
end
