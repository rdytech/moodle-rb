require 'spec_helper'

describe Moodle::Client do
  let(:url) { ENV['MOODLE_URL'] || 'moodle.localhost' }
  let(:token) { ENV['MOODLE_TOKEN'] || '' }
  let(:moodle) { Moodle.new(token, url) }

  describe '#site_info', :vcr => {
    :match_requests_on => [:body, :headers], :record => :once
  } do
    let(:result) { moodle.site_info }

    context 'when invalid token' do
      let(:token) { 'invalid_moodle_token' }

      specify do
        expect(result).to be_a Hash
        expect(result['errorcode']).to eq 'invalidtoken'
      end
    end

    context 'when valid token' do
      specify do
        expect(result).to be_a Hash
        expect(result['release']).to eq '2.8.3+ (Build: 20150212)'
      end
    end
  end

  describe '#courses' do
    specify { expect(moodle.courses).to be_a Moodle::Courses }
  end

  describe '#categories' do
    specify { expect(moodle.categories).to be_a Moodle::Categories }
  end

  describe '#users' do
    specify { expect(moodle.users).to be_a Moodle::Users }
  end

  describe '#enrolments' do
    specify { expect(moodle.enrolments).to be_a Moodle::Enrolments }
  end
end
