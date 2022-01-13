require 'spec_helper'

describe MoodleRb do
  let(:url) { ENV['MOODLE_URL'] || 'localhost:8888/moodle28' }
  let(:token) { ENV['MOODLE_TOKEN'] || '60fc9c9415259404795094957e4ab32f' }
  let(:moodle_rb) { MoodleRb.new(token, url) }

  describe 'new' do
    specify { expect(moodle_rb).to be_a MoodleRb::Client }
  end
end
