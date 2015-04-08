require 'spec_helper'

describe Moodle::Users do
  let(:url) { ENV['MOODLE_URL'] || 'moodle.localhost' }
  let(:token) { ENV['MOODLE_TOKEN'] || '' }
  let(:user_moodle) { Moodle.new(token, url).users }

  describe '#create', :vcr => {
    :match_requests_on => [:headers], :record => :once
  } do
    let(:params) do
      {
        :username => 'testuser1',
        :password => 'Password123',
        :firstname => 'Austin',
        :lastname => 'Powers',
        :email => 'austinp1@jobready.com.au',
        :idnumber => 'PAUST002'
      }
    end
    let(:result) { user_moodle.create(params) }

    specify do
      expect(result).to be_a Hash
      expect(result).to have_key 'username'
      expect(result['id']).to eq 87
    end
  end

  describe '#show', :vcr => {
    :match_requests_on => [:headers], :record => :once
  } do
    let(:id) { 87 }
    let(:result) { user_moodle.show(id) }

    specify do
      expect(result).to be_a Hash
      expect(result['id']).to eq 87
      expect(result['username']).to eq 'testuser1'
    end
  end

  describe '#destroy', :vcr => {
    :match_requests_on => [:headers], :record => :once
  } do
    let(:id) { 87 }
    let(:result) { user_moodle.destroy(id) }

    specify do
      expect(result).to eq true
    end
  end

  describe '#enrolled_courses', :vcr => {
    :match_requests_on => [:headers], :record => :once
  } do
    let(:user_id) { 86 }
    let(:result) { user_moodle.enrolled_courses(user_id) }
    let(:enrolment) { result.first }

    specify do
      expect(result).to be_a Array
      expect(enrolment).to have_key 'shortname'
    end
  end
end
