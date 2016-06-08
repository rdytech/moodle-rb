require 'spec_helper'

describe MoodleRb::Users do
  let(:url) { ENV['MOODLE_URL'] || 'localhost' }
  let(:token) { ENV['MOODLE_TOKEN'] || '' }
  let(:user_moodle_rb) { MoodleRb.new(token, url).users }

  describe '#create', :vcr => {
    :match_requests_on => [:headers], :record => :once
  } do
    let(:params) do
      {
        :username => 'testuser1',
        :password => 'Password123!',
        :firstname => 'Austin',
        :lastname => 'Powers',
        :email => 'austinp1@jobready.com.au',
        :idnumber => 'PAUST002'
      }
    end
    let(:result) { user_moodle_rb.create(params) }

    specify do
      expect(result).to be_a Hash
      expect(result).to have_key 'username'
      expect(result['id']).to eq 5
    end

    context 'when missing required parameters' do
      let(:params) do
        {
          :username => 'testuser1'
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

  describe '#show', :vcr => {
    :match_requests_on => [:headers], :record => :once
  } do
    let(:id) { 5 }
    let(:result) { user_moodle_rb.show(id) }

    specify do
      expect(result).to be_a Hash
      expect(result['id']).to eq 5
    end
  end

  describe '#destroy', :vcr => {
    :match_requests_on => [:headers], :record => :once
  } do
    let(:id) { 5 }
    let(:result) { user_moodle_rb.destroy(id) }

    specify do
      expect(result).to eq true
    end

    context 'when id does not exist' do
      let(:id) { 999 }
      specify do
        expect(result).to eq false
      end
    end
  end

  describe '#enrolled_courses', :vcr => {
    :match_requests_on => [:headers], :record => :once
  } do
    let(:user_id) { 3 }
    let(:result) { user_moodle_rb.enrolled_courses(user_id) }
    let(:enrolment) { result.first }

    specify do
      expect(result).to be_a Array
      expect(enrolment).to have_key 'shortname'
    end
  end

  describe '#search', :vcr => {
    :match_requests_on => [:headers], :record => :once
  } do
    let(:results) { user_moodle_rb.search({ :firstname => 'Guest%' }) }

    specify do
      expect(results).to be_a Array
      expect(results.first).to be_a Hash
      expect(results.first['firstname']).to eq 'Guest user'
    end
  end
end
