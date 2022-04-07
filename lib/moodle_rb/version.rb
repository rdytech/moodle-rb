module MoodleRb
  VERSION = '2.0.0' unless defined?(self::VERSION)

  def self.version
    VERSION
  end
end
