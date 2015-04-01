require 'spec_helper'

describe Moodle do
  let(:url) { ENV['MOODLE_URL'] }
  let(:token) { ENV['MOODLE_TOKEN'] }
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
end
