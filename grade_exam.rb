class Exam
  attr_accessor :filename

  ANSWER_PATTERN = /^(?<number>\d+)\.\s*(?<answer>\w)$/

  def initialize(filename)
    @filename = filename
  end

  def actual_answers
    @actual_answers ||= Exam.answers(filename)
  end

  def self.correct_answers
    @correct_answers ||= answers('exams/answers.txt')
  end

  def grade
    Exam.correct_answers.each_with_object({}) do |number_correct, memo|
      number, correct = number_correct
      actual = actual_answers[number] || ''

      actual = actual.upcase
      correct = correct.upcase

      memo[number] = {}
      memo[number][:actual] = actual
      memo[number][:expected] = correct
      memo[number][:correct] = actual == correct
    end
  end

  def self.answers(filename)
    File.open(filename).each_with_object({}) do |line, memo|
      line = line.strip

      match = line.match(ANSWER_PATTERN)

      next unless match

      memo[match[:number].to_i] = match[:answer]
    end
  end
end

def main
  filename = ARGV[0] || 'exam1.txt'
  exam = Exam.new(filename)
  grade = exam.grade

  incorrect = grade.select do |key, values|
    !values[:correct]
  end

  puts "Grade for #{filename}: #{grade.size - incorrect.size} / #{grade.size}"

  incorrect.each do |key, values|
    puts "#{key}: #{values[:correct]} (actual: #{values[:actual]}, expected: #{values[:expected]})"
  end
end

if __FILE__ == $0
  main
end
