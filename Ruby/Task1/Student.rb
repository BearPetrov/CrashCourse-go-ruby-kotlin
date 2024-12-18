require 'date'

class Student
  attr_accessor :surname, :name, :date_of_birth

  @@students = []

  def initialize(surname, name, date_of_birth)
    @surname = surname
    @name = name
    @date_of_birth = date_of_birth

   
    raise ArgumentError, "Дата народження не повинна бути в майбутньому" if @date_of_birth > Date.today

    add_student
  end

  def calculate_age
    today = Date.today
    age = today.year - @date_of_birth.year
    age -= 1 if today < @date_of_birth + 365.25
    age.to_i
  end

  def add_student
    if @@students.any? { |student| student.surname == @surname && student.name == @name && student.date_of_birth == @date_of_birth }
      "Student already added"
    else
      @@students << self
      "Student added successfully"
    end
  end

  def remove_student
    @@students.delete(self)
  end

  def self.verification(details)
    @@students.any? do |student|
      student.surname == details[:surname] &&
      student.name == details[:name] &&
      student.date_of_birth == details[:date_of_birth]
    end
  end

  def self.get_students_by_age(age)
    @@students.select { |student| student.calculate_age == age }.map do |student|
      {
        surname: student.surname,
        name: student.name,
        date_of_birth: student.date_of_birth
      }
    end
  end

  def self.get_students_by_name(name)
    @@students.select { |student| student.name == name }.map do |student|
      {
        surname: student.surname,
        name: student.name,
        date_of_birth: student.date_of_birth
      }
    end
  end

  def self.all_students
    @@students
  end
end



#Test
# begin
# student1 = Student.new("Petrov", "Michael", Date.new(2011, 11, 11))
# student2 = Student.new("Petrov", "Oliver", Date.new(2005, 5, 5))
# student3 = Student.new("Petrov", "Michael", Date.new(2011, 11, 11))
# student4 = Student.new("Smith", "Jack", Date.new(2034, 4, 1))
# rescue ArgumentError => e
#     puts e.message
#   end

#   puts "Всі студенти:"
#   Student.all_students.each do |student|
#     puts "Призвище: #{student.surname}, Ім'я: #{student.name}, Дата народження: #{student.date_of_birth}, Вік: #{student.calculate_age}"
#   end

#   puts "\nСтуденти віком 19 років:"
#   students_age_19 = Student.get_students_by_age(19)
#   students_age_19.each do |student|
#     puts "Прізвище: #{student.surname}, Ім'я: #{student.name}, Дата народження: #{student.date_of_birth}, Вік: #{student.calculate_age}"
#   end

#   puts "\nСтуденти з іменем 'Michael':"
# students_named_michael = Student.get_students_by_name("Michael")
# students_named_michael.each do |student|
#   puts "Прізвище: #{student.surname}, Ім'я: #{student.name}, Дата народження: #{student.date_of_birth}, Вік: #{student.calculate_age}"
# end

# puts "\nВидалення студента Oliver"
# student2.remove_student

# puts "\nВсі студенти після видалення:"
# Student.all_students.each do |student|
#   puts "Прізвище: #{student.surname}, Ім'я: #{student.name}, Дата народження: #{student.date_of_birth}, Вік: #{student.calculate_age}"
# end

