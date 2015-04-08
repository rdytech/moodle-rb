require 'spec_helper'

describe Moodle::Enrolments do
  let(:url) { ENV['MOODLE_URL'] || 'moodle.localhost' }
  let(:token) { ENV['MOODLE_TOKEN'] || '' }
  let(:enrolment_moodle) { Moodle.new(token, url).enrolments }

  describe '#create', :vcr => {
    :match_requests_on => [:headers], :record => :once
  } do
    let(:params) do
      {
        :user_id => 86,
        :course_id => 30
      }
    end
    let(:result) { enrolment_moodle.create(params) }

    specify do
      expect(result).to eq true
    end
  end
end
