require 'spec_helper'

describe MoodleRb::MoodleError do
  describe '#new' do
    let(:response_body) do
      {
        'exception' => 'moodle_rb_exception',
        'errorcode' => 'categoryidnumbertaken',
        'message' => 'ID number is already used for another category'
      }
    end
    let!(:exception) { MoodleRb::MoodleError.new(response_body) }

    specify do
      expect(exception.message).to eq 'ID number is already used for another category'
      expect(exception.code).to eq 'categoryidnumbertaken'
      expect(exception.response_body).to eq response_body
    end
  end
end
