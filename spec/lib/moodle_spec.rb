require 'spec_helper'

describe Moodle do
  let(:url) { ENV['MOODLE_URL'] || 'moodle.localhost' }
  let(:token) { ENV['MOODLE_TOKEN'] || '' }
  let(:moodle) { Moodle.new(token, url) }

  describe 'new' do
    specify { expect(moodle).to be_a Moodle::Client }
  end
end
