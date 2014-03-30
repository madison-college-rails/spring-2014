require_relative 'grade_exam'

describe Exam do
  describe '.correct_answers' do
    it 'is a Hash' do
      expect(Exam.correct_answers).to be_a Hash
    end
  end
end
