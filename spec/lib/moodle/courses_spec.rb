require 'spec_helper'

describe Moodle::Courses do
  let(:url) { ENV['MOODLE_URL'] || 'moodle.localhost' }
  let(:token) { ENV['MOODLE_TOKEN'] || '' }
  let(:course_moodle) { Moodle.new(token, url).courses }

  describe '#index', :vcr => {
    :match_requests_on => [:body, :headers], :record => :once
  } do
    let(:result) { course_moodle.index }

    specify do
      expect(result).to be_a Array
      expect(result.first).to have_key 'id'
    end
  end

  describe '#create', :vcr => {
    :match_requests_on => [:headers], :record => :once
  } do
    let(:params) do
      {
        :full_name => 'Test Course',
        :short_name => 'TestC1',
        :parent_category => 5,
        :idnumber => 'ExtRef1'
      }
    end
    let(:result) { course_moodle.create(params) }

    specify do
      expect(result).to be_a Hash
      expect(result).to have_key 'id'
      expect(result).to have_key 'shortname'
    end
  end

  describe '#show', :vcr => {
    :match_requests_on => [:headers], :record => :once
  } do
    let(:id) { 42 }
    let(:result) { course_moodle.show(id) }

    specify do
      expect(result).to be_a Hash
      expect(result['id']).to eq 42
      expect(result['shortname']).to eq 'TestC'
    end
  end

  describe '#destroy', :vcr => {
    :match_requests_on => [:headers], :record => :once
  } do
    let(:id) { 43 }
    let(:result) { course_moodle.destroy(id) }

    specify do
      expect(result).to eq true
    end
  end

  describe '#enrolled_users', :vcr => {
    :match_requests_on => [:headers], :record => :once
  } do
    let(:course_id) { 30 }
    let(:result) { course_moodle.enrolled_users(course_id) }
    let(:enrolment) { result.first }

    specify do
      expect(result).to be_a Array
      expect(enrolment).to have_key 'username'
    end
  end
end
