require 'spec_helper'
include MoodleRb::Utility

describe MoodleRb::Utility do
  describe '#api_array' do
    let(:result) { api_array(input) }

    context 'when array provided' do
      let(:output) { {0=>1, 1=>2} }
      specify { expect(api_array([1, 2])).to eq output }
    end

    context 'when single value provided' do
      let(:output) { {0=>1} }
      specify { expect(api_array(1)).to eq output }
    end

    context 'when multiple values provided' do
      let(:output) { {0=>1, 1=>5, 2=>8} }
      specify { expect(api_array(1, 5, 8)).to eq output }
    end
  end
end
