require 'spec_helper'

describe MoodleRb::Grades do
  let(:url) { ENV['MOODLE_URL'] || 'localhost:8888/moodle28' }
  let(:token) { ENV['MOODLE_TOKEN'] || '60fc9c9415259404795094957e4ab32f' }
  let(:grade_moodle_rb) { MoodleRb.new(token, url).grades }

  describe '#by_assignment', :vcr => {
    :match_requests_on => [:path], :record => :once
  } do
    let(:assignment_id) { 1 }
    let(:result) { grade_moodle_rb.by_assignment(assignment_id) }

    specify do
      expect(result).to be_a Array
      expect(result.first).to have_key 'assignmentid'
    end
  end

  describe '#by_course', :vcr => {
    :match_requests_on => [:path], :record => :once
  } do
    let(:course_id) { 8 }
    let(:user_ids) { 5 }
    let(:result) { grade_moodle_rb.by_course(course_id, user_ids) }

    specify do
      expect(result).to be_a Array
      expect(result.first).to have_key 'activityid'
    end

    context 'when invalid parameters' do
      let(:user_ids) { 'ABC' }

      specify do
        expect{ result }.to raise_error(
          MoodleRb::MoodleError,
          'Invalid parameter value detected'
        )
      end
    end
  end
end
