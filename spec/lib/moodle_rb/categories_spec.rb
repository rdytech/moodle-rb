require 'spec_helper'

describe MoodleRb::Categories do
  let(:url) { ENV['MOODLE_URL'] || 'localhost' }
  let(:token) { ENV['MOODLE_TOKEN'] || '' }
  let(:category_moodle_rb) { MoodleRb.new(token, url).categories }

  describe '#index', :vcr => {
    :match_requests_on => [:body, :headers], :record => :once
  } do
    let(:result) { category_moodle_rb.index }

    specify do
      expect(result).to be_a Array
      expect(result.first).to have_key 'id'
    end

    context 'when using invalid token' do
      let(:token) { '' }
      specify do
        expect{ category_moodle_rb.index }.to raise_error(
          MoodleRb::MoodleError,
          'Invalid token - token not found'
        )
      end
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
    let(:result) { category_moodle_rb.create(params) }

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
          MoodleRb::MoodleError,
          'ID number is already used for another category'
        )
      end
    end
  end

  describe '#show', :vcr => {
    :match_requests_on => [:headers], :record => :once
  } do
    let(:id) { 1 }
    let(:result) { category_moodle_rb.show(id) }

    specify do
      expect(result).to be_a Hash
      expect(result['id']).to eq 1
    end

    context 'when using invalid token' do
      let(:token) { '' }
      specify do
        expect{ category_moodle_rb.show(id) }.to raise_error(
          MoodleRb::MoodleError,
          'Invalid token - token not found'
        )
      end
    end
  end

  describe '#destroy', :vcr => {
    :match_requests_on => [:headers], :record => :once
  } do
    context 'when using valid token' do
      let!(:id) { category_moodle_rb.create(:name => '_')['id'] }
      let(:result) { category_moodle_rb.destroy(id) }

      specify do
        expect(result).to eq true
      end
    end

    context 'when using invalid token' do
      let(:token) { '' }
      specify do
        expect{ category_moodle_rb.destroy(0) }.to raise_error(
          MoodleRb::MoodleError,
          'Invalid token - token not found'
        )
      end
    end
  end
end
