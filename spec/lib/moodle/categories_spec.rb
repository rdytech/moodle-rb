require 'spec_helper'

describe Moodle::Categories do
  let(:url) { ENV['MOODLE_URL'] || 'moodle.localhost' }
  let(:token) { ENV['MOODLE_TOKEN'] || '' }
  let(:category_moodle) { Moodle.new(token, url).categories }

  describe '#index', :vcr => {
    :match_requests_on => [:body, :headers], :record => :once
  } do
    let(:result) { category_moodle.index }

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
        :name => 'Test category'
      }
    end
    let(:result) { category_moodle.create(params) }

    specify do
      expect(result).to be_a Hash
      expect(result).to have_key 'id'
      expect(result).to have_key 'name'
    end

    context 'when validation fails' do
      let(:params) do
        {
          :name => 'Test category',
          :idnumber => 'CAT101'
        }
      end

      specify do
        expect{ result }.to raise_error(
          Moodle::MoodleError,
          'ID number is already used for another category'
        )
      end
    end
  end

  describe '#show', :vcr => {
    :match_requests_on => [:headers], :record => :once
  } do
    let(:id) { 12 }
    let(:result) { category_moodle.show(id) }

    specify do
      expect(result).to be_a Hash
      expect(result['id']).to eq 12
      expect(result['name']).to eq 'Test category'
    end
  end

  describe '#destroy', :vcr => {
    :match_requests_on => [:headers], :record => :once
  } do
    let(:id) { 12 }
    let(:result) { category_moodle.destroy(id) }

    specify do
      expect(result).to eq true
    end
  end
end
