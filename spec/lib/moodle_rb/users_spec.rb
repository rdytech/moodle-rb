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

    context 'when using invalid token' do
      let(:token) { '' }
      specify do
        expect{ user_moodle_rb.show(id) }.to raise_error(
          MoodleRb::MoodleError,
          'Invalid token - token not found'
        )
      end
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
        expect{ result }.to raise_error(
          MoodleRb::MoodleError,
          'Invalid user'
        )
      end
    end

    context 'when using invalid token' do
      let(:token) { '' }
      specify do
        expect{ user_moodle_rb.destroy(-1) }.to raise_error(
          MoodleRb::MoodleError,
          'Invalid token - token not found'
        )
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

    context 'when using invalid token' do
      let(:token) { '' }
      specify do
        expect{ user_moodle_rb.enrolled_courses(user_id) }.to raise_error(
          MoodleRb::MoodleError,
          'Invalid token - token not found'
        )
      end
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

    context 'when using invalid token' do
      let(:token) { '' }
      specify do
        expect{ user_moodle_rb.search({ :firstname => '%' }) }.to raise_error(
          MoodleRb::MoodleError,
          'Invalid token - token not found'
        )
      end
    end
  end

  describe '#search_identity', :vcr => {
    :match_requests_on => [:headers], :record => :once
  } do
    let(:results) { user_moodle_rb.search_identity('moodle_student@mailinator.com') }

    specify do
      expect(results).to be_a Array
      expect(results.first).to be_a Hash
      expect(results.first['id']).to eq 25
      expect(results.first['fullname']).to eq 'Moodle Student'
      expect(results.first['extrafields'].first['name']).to eq 'idnumber'
      expect(results.first['extrafields'].first['value']).to eq 'MS01'
      expect(results.first['extrafields'].last['name']).to eq 'email'
      expect(results.first['extrafields'].last['value']).to eq 'moodle_student@mailinator.com'
    end

    context 'when using invalid token' do
      let(:token) { '' }
      specify do
        expect do
          user_moodle_rb.search_identity('moodle_student@mailinator.com')
        end.to raise_error(
          MoodleRb::MoodleError,
          'Invalid token - token not found'
        )
      end
    end
  end

  describe '#update', :vcr => {
    :match_requests_on => [:headers], :record => :once
  } do
    let(:user_id) { 4 }
    let(:result) do
      user_moodle_rb.update(:id => user_id, :email => 'samg@jobready.com.au')
    end

    specify do
      expect(result).to eq true
    end

    context 'when using invalid token' do
      let(:token) { '' }
      specify do
        expect do
          user_moodle_rb.update(:id => user_id, :email => '')
        end.to raise_error(
          MoodleRb::MoodleError,
          'Invalid token - token not found'
        )
      end
    end
  end
end
