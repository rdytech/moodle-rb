require 'spec_helper'

describe Moodle::MoodleError do
  describe '#new' do
    let(:response_body) do
      {
        'exception' => 'moodle_exception',
        'errorcode' => 'categoryidnumbertaken',
        'message' => 'ID number is already used for another category'
      }
    end
    let!(:exception) { Moodle::MoodleError.new(response_body) }

    specify do
      expect(exception.message).to eq 'ID number is already used for another category'
      expect(exception.code).to eq 'categoryidnumbertaken'
      expect(exception.response_body).to eq response_body
    end
  end
end
