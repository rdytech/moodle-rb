require 'spec_helper'

describe Courses do
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
        :short_name => 'TestC',
        :parent_category => 5,
        :idnumber => 'ExtRef'
      }
    end
    let(:result) { course_moodle.create(params) }

    specify do
      expect(result).to be_a Hash
      expect(result).to have_key 'id'
      expect(result).to have_key 'shortname'
    end
  end
end
