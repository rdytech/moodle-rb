require 'spec_helper'

describe Users do
  let(:url) { ENV['MOODLE_URL'] || 'moodle.localhost' }
  let(:token) { ENV['MOODLE_TOKEN'] || '' }
  let(:user_moodle) { Moodle.new(token, url).users }

  describe '#create', :vcr => {
    :match_requests_on => [:headers], :record => :once
  } do
    let(:params) do
      {
        :username => 'testuser',
        :password => 'Password123',
        :firstname => 'Austin',
        :lastname => 'Powers',
        :email => 'austinp@jobready.com.au',
        :idnumber => 'PAUST001'
      }
    end
    let(:result) { user_moodle.create(params) }

    specify do
      expect(result).to be_a Hash
      expect(result).to have_key 'username'
      expect(result['id']).to eq 85
    end
  end

  describe '#show', :vcr => {
    :match_requests_on => [:headers], :record => :once
  } do
    let(:id) { 85 }
    let(:result) { user_moodle.show(id) }

    specify do
      expect(result).to be_a Hash
      expect(result['id']).to eq 85
      expect(result['username']).to eq 'testuser'
    end
  end

  describe '#destroy', :vcr => {
    :match_requests_on => [:headers], :record => :once
  } do
    let(:id) { 85 }
    let(:result) { user_moodle.destroy(id) }

    specify do
      expect(result).to eq true
    end
  end
end
