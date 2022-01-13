require 'spec_helper'

describe MoodleRb::Enrolments do
  let(:url) { ENV['MOODLE_URL'] || 'localhost:8888/moodle28' }
  let(:token) { ENV['MOODLE_TOKEN'] || '60fc9c9415259404795094957e4ab32f' }
  let(:enrolment_moodle_rb) { MoodleRb.new(token, url).enrolments }

  describe '#create', :vcr => {
    :match_requests_on => [:path], :record => :once
  } do
    let(:params) do
      {
        :user_id => 3,
        :course_id => 8
      }
    end
    let(:result) { enrolment_moodle_rb.create(params) }

    specify do
      expect(result).to eq true
    end

    context 'when user or course id is invalid' do
      let(:params) do
        {
          :user_id => 9999,
          :course_id => 9999
        }
      end

      specify do
        expect{ result }.to raise_error(
          MoodleRb::MoodleError,
          'Invalid parameter value detected'
        )
      end
    end
  end

  describe '#destroy', :vcr => {
    :match_requests_on => [:path], :record => :once
  } do
    let(:params) do
      {
        :user_id => '7',
        :course_id => '5'
      }
    end

    let(:result) { enrolment_moodle_rb.destroy(params) }

    specify do
      expect(result).to eq true
    end

    context 'when user or course id is invalid' do
      let(:params) do
        {
          :user_id => 9999,
          :course_id => 9999
        }
      end

      specify do
        expect{ result }.to raise_error(
          MoodleRb::MoodleError,
          "Can't find data record in database table course."
        )
      end
    end
  end
end
