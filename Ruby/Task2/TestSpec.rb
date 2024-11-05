require 'minitest/autorun'
require 'minitest/spec'
require 'minitest/reporters'
require 'date'
require_relative "../Task1/Student"

Minitest::Reporters.use! [
   Minitest::Reporters::SpecReporter.new,
   Minitest::Reporters::HtmlReporter.new(
     reports_dir: 'Ruby/Task2/report/spec',
     report_filename: 'spec_results.html',
     clean: true,
     add_timestamp: true
   )
]

describe Student do
  before do
    @student1 = Student.new("Petrov", "Michael", Date.new(2011, 11, 11))
    @student2 = Student.new("Petrov", "Oliver", Date.new(2005, 5, 5))
 
    @student1.add_student
    @student2.add_student
  end

  after do
    Student.class_variable_set(:@@students, [])
  end

  describe "#test-parsing" do
  it "raises an error if the date is in the past" do
     expect { Student.new('Wars', 'Stas', Date.new(2100 ,10 ,02)) }.must_raise ArgumentError
  end
end

  describe '#calculate_age' do
    it 'calculates the correct age for student1' do
      expected_age = Date.today.year - 2011
      expect(@student1.calculate_age).must_equal(expected_age)
    end

    it 'calculates the correct age for student2' do
      expected_age = Date.today.year - 2005
      expect(@student2.calculate_age).must_equal(expected_age)
    end
  end

  describe '#add_student' do
    it 'returns a message when the student is already added' do
      expect(@student1.add_student).must_equal("Student already added")
    end
  end

  describe '.verification' do
    it 'verifies that an existing student is recognized' do
      expect(Student.verification({
        surname: "Petrov",
        name: "Michael",
        date_of_birth: Date.new(2011, 11, 11)
      })).must_equal(true)
    end

    it 'does not verify a non-existing student' do
      expect(Student.verification({
        surname: "Anopka",
        name: "Petropka",
        date_of_birth: Date.new(2004, 8, 26)
      })).must_equal(false)
    end
  end

  describe '#remove_student' do
    it 'removes the student correctly' do
      @student1.remove_student
      expect(Student.verification({
        surname: "Petrov",
        name: "Michael",
        date_of_birth: Date.new(2011, 11, 11)
      })).must_equal(false)
    end
  end

  describe '.get_students_by_age' do
    it 'returns the correct student by age' do
      target_age = Date.today.year - 2011
      expect(Student.get_students_by_age(target_age)).must_equal([{
        surname: "Petrov",
        name: "Michael",
        date_of_birth: Date.new(2011, 11, 11)
      }])
    end
  end

  describe '.get_students_by_name' do
    it 'returns the correct student by name' do
      expect(Student.get_students_by_name("Oliver")).must_equal([{
        surname: "Petrov",
        name: "Oliver",
        date_of_birth: Date.new(2005, 5, 5)
      }])
    end
  end
end