# Homework

Create a Student class with the following requirements:

1. Properties:
- surname
- name
- date of birth
2. Class variable:
- students: maintains a list of all unique students
3. Validations:
- Date of birth must be in the past
- If date of birth is in the future, raise ArgumentError
- Prevent duplicate students in the list (same name, surname, and date of birth)
4. Methods:
- calculate_age(): returns the person's current age
- add_student(): adds a student to the class list (if not already present)
- remove_student(): removes a student from the class list
- get_students_by_age(age): returns students of specified age
- get_students_by_name(name): returns students with specified name

Note: The class should keep track of all created Student instances in the students list, ensuring no duplicates are added."
