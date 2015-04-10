require 'spec_helper'

describe MoodleRb do
  let(:url) { ENV['MOODLE_URL'] || 'localhost' }
  let(:token) { ENV['MOODLE_TOKEN'] || '' }
  let(:moodle_rb) { MoodleRb.new(token, url) }

  describe 'new' do
    specify { expect(moodle_rb).to be_a MoodleRb::Client }
  end
end
