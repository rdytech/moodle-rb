require 'spec_helper'

describe MoodleRb::Client do
  let(:url) { ENV['MOODLE_URL'] || 'localhost' }
  let(:token) { ENV['MOODLE_TOKEN'] || '' }
  let(:moodle_rb) { MoodleRb.new(token, url) }

  describe '#site_info', :vcr => {
    :match_requests_on => [:body, :headers], :record => :once
  } do
    let(:result) { moodle_rb.site_info }

    context 'when invalid token' do
      let(:token) { 'invalid_moodle_rb_token' }

      specify do
        expect(result).to be_a Hash
        expect(result['errorcode']).to eq 'invalidtoken'
      end
    end

    context 'when valid token' do
      specify do
        expect(result).to be_a Hash
        expect(result['release']).to eq '2.8.5+ (Build: 20150313)'
      end
    end
  end

  describe '#courses' do
    specify { expect(moodle_rb.courses).to be_a MoodleRb::Courses }
  end

  describe '#categories' do
    specify { expect(moodle_rb.categories).to be_a MoodleRb::Categories }
  end

  describe '#users' do
    specify { expect(moodle_rb.users).to be_a MoodleRb::Users }
  end

  describe '#enrolments' do
    specify { expect(moodle_rb.enrolments).to be_a MoodleRb::Enrolments }
  end
end
