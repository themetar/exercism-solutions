class School
  Student = Struct.new(:name, :grade)
  
  def initialize
    @students = []
  end

  def add(name, grade)
    return false if @students.any? { |student| student.name == name }
    
    @students.push(Student.new(name, grade))

    true
  end

  def roster
    @students.sort { |a, b| a.grade == b.grade ? a.name <=> b.name : a.grade - b.grade }
              .map(&:name)
  end

  def grade(number)
    @students.filter { |s| s.grade == number }
                .map(&:name)
                .sort
  end
end
