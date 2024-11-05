require 'minitest/autorun'
require 'minitest/reporters'
require 'date'
require_relative "../Task1/Student"

Minitest::Reporters.use! [
  Minitest::Reporters::HtmlReporter.new(
    reports_dir: 'Ruby/Task2/report/unit',
    report_filename: 'unit_results.html',
    clean: true,
    add_timestamp: true
  )
]

class UserTest < Minitest::Test
  def setup
    @student1 = Student.new("Petrov", "Michael", Date.new(2011, 11, 11))
    @student2 = Student.new("Petrov", "Oliver", Date.new(2005, 5, 5))

    @student1.add_student
    @student2.add_student
  end

  def teardown
    Student.class_variable_set(:@@students, [])
  end

  def test_parsing_raises_error_for_future_date
    assert_raises(ArgumentError) do
      Student.new('Wars', 'Stas', Date.new(2100, 10, 2))
    end
  end

  def test_calculate_age_for_student1
    expected_age = Date.today.year - 2011
    assert_equal expected_age, @student1.calculate_age
  end

  def test_calculate_age_for_student2
    expected_age = Date.today.year - 2005
    assert_equal expected_age, @student2.calculate_age
  end

  def test_add_student_returns_message_when_already_added
    assert_equal "Student already added", @student1.add_student
  end

  def test_verification_recognizes_existing_student
    result = Student.verification({
      surname: "Petrov",
      name: "Michael",
      date_of_birth: Date.new(2011, 11, 11)
    })
    assert_equal true, result
  end

  def test_verification_does_not_recognize_non_existing_student
    result = Student.verification({
      surname: "Anopka",
      name: "Petropka",
      date_of_birth: Date.new(2004, 8, 26)
    })
    assert_equal false, result
  end

  def test_remove_student_removes_student_correctly
    @student1.remove_student
    result = Student.verification({
      surname: "Petrov",
      name: "Michael",
      date_of_birth: Date.new(2011, 11, 11)
    })
    assert_equal false, result
  end

  def test_get_students_by_age_returns_correct_student
    target_age = Date.today.year - 2011
    expected_student = [{
      surname: "Petrov",
      name: "Michael",
      date_of_birth: Date.new(2011, 11, 11)
    }]
    assert_equal expected_student, Student.get_students_by_age(target_age)
  end

  def test_get_students_by_name_returns_correct_student
    expected_student = [{
      surname: "Petrov",
      name: "Oliver",
      date_of_birth: Date.new(2005, 5, 5)
    }]
    assert_equal expected_student, Student.get_students_by_name("Oliver")
  end
end
