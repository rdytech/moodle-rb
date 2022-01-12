require 'spec_helper'

describe MoodleRb::Courses do
  let(:url) { ENV['MOODLE_URL'] || 'localhost:8888/moodle28' }
  let(:token) { ENV['MOODLE_TOKEN'] || '60fc9c9415259404795094957e4ab32f' }
  let(:course_moodle_rb) { MoodleRb.new(token, url).courses }
  let(:params) do
    {
      :full_name => 'Test Course',
      :short_name => 'TestC1',
      :parent_category => 1,
      :idnumber => 'ExtRef'
    }
  end

  describe '#index', :vcr => {
    :match_requests_on => [:body, :path], :record => :once
  } do
    let(:result) { course_moodle_rb.index }

    specify do
      expect(result).to be_a Array
      expect(result.first).to have_key 'id'
    end

    context 'when using invalid token' do
      let(:token) { '' }
      specify do
        expect{ course_moodle_rb.index }.to raise_error(
          MoodleRb::MoodleError,
          'Invalid token - token not found'
        )
      end
    end
  end

  describe '#create', :vcr => {
    :match_requests_on => [:path], :record => :once
  } do
    let(:result) { course_moodle_rb.create(params) }

    specify do
      expect(result).to be_a Hash
      expect(result).to have_key 'id'
      expect(result).to have_key 'shortname'
    end

    context 'when validation fails' do
      before do
        course_moodle_rb.create(params)
      end

      specify do
        expect{ result }.to raise_error(
          MoodleRb::MoodleError,
          'Short name is already used for another course (TestC1)'
        )
      end
    end
  end

  describe '#show', :vcr => {
    :match_requests_on => [:path], :record => :once
  } do
    let(:id) { 1 }
    let(:result) { course_moodle_rb.show(id) }

    specify do
      expect(result).to be_a Hash
      expect(result['id']).to eq 1
    end

    context 'when using invalid token' do
      let(:token) { '' }
      specify do
        expect{ course_moodle_rb.show(id) }.to raise_error(
          MoodleRb::MoodleError,
          'Invalid token - token not found'
        )
      end
    end
  end

  describe '#destroy', :vcr => {
    :match_requests_on => [:path], :record => :once
  } do
    context 'when using valid token' do
      let(:id) { course_moodle_rb.create(params)['id'] }
      let(:result) { course_moodle_rb.destroy(id) }

      specify do
          expect(result).to be_a Hash
          expect(result['warnings']).to be_a Array
          expect(result['warnings']).to be_empty
      end

      context 'when using invalid course id' do
        let(:result) { course_moodle_rb.destroy(-1) }

        specify do
          expect(result).to be_a Hash
          expect(result['warnings']).to be_a Array
          expect(result['warnings'][0]['warningcode']).to eq 'unknowncourseidnumber'
        end
      end
    end

    context 'when using invalid token' do
      let(:token) { '' }
      specify do
        expect{ course_moodle_rb.destroy(-1) }.to raise_error(
          MoodleRb::MoodleError,
          'Invalid token - token not found'
        )
      end
    end
  end

  describe '#enrolled_users', :vcr => {
    :match_requests_on => [:path], :record => :once
  } do
    let(:course_id) { 8 }

    context 'when using valid token' do
      let!(:enrolled_user) do
        MoodleRb.new(token, url).enrolments.create(
          :user_id => 3, :course_id => course_id)
      end
      let(:result) { course_moodle_rb.enrolled_users(course_id) }
      let(:enrolment) { result.first }

      specify do
        expect(result).to be_a Array
        expect(enrolment).to have_key 'id'
        expect(enrolment).to have_key 'enrolledcourses'
      end
    end

    context 'when using invalid token' do
      let(:token) { '' }
      specify do
        expect{ course_moodle_rb.enrolled_users(course_id) }.to raise_error(
          MoodleRb::MoodleError,
          'Invalid token - token not found'
        )
      end
    end
  end

  describe '#grade_items', :vcr => {
    :match_requests_on => [:path], :record => :once
  } do
    let(:course_id) { 5 }

    context 'when using valid token' do
      let(:result) { course_moodle_rb.grade_items(course_id) }
      let(:user_grades) { result.first }

      specify do
        expect(result).to be_a Array
        expect(user_grades).to have_key 'gradeitems'
      end
    end

    context 'when using invalid token' do
      let(:token) { '' }
      specify do
        expect{ course_moodle_rb.grade_items(course_id) }.to raise_error(
          MoodleRb::MoodleError,
          'Invalid token - token not found'
        )
      end
    end
  end

  describe '#contents', :vcr => {
    :match_requests_on => [:path], :record => :once
  } do
    let(:course_id) { 5 }

    context 'when using valid token' do
      let(:result) { course_moodle_rb.contents(course_id) }
      let(:enrolment) { result.first }

      specify do
        expect(result).to be_a Hash
        expect(result).to have_key 'modules'
      end
    end

    context 'when using invalid token' do
      let(:token) { '' }
      specify do
        expect{ course_moodle_rb.contents(course_id) }.to raise_error(
          MoodleRb::MoodleError,
          'Invalid token - token not found'
        )
      end
    end
  end

  describe '#module', :vcr => {
    :match_requests_on => [:path], :record => :once
  } do
    let(:course_module_id) { 21 }

    context 'when using valid token' do
      let(:result) { course_moodle_rb.module(course_module_id) }

      specify do
        expect(result).to be_a Hash
        expect(result).to have_key 'name'
        expect(result).to have_key 'gradepass'
      end
    end

    context 'when using invalid token' do
      let(:token) { '' }
      specify do
        expect{ course_moodle_rb.module(course_module_id) }.to raise_error(
          MoodleRb::MoodleError,
          'Invalid token - token not found'
        )
      end
    end
  end
end
