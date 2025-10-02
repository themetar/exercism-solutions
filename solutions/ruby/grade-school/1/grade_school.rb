class School
  def initialize
    @roster = {}
  end

  def add(name, grade)
    @roster[grade] = [] if @roster[grade].nil?

    @roster[grade].push(name)
    @roster[grade].sort!
  end

  def students(grade)
    @roster[grade] = [] if @roster[grade].nil?

    @roster[grade]
  end

  def students_by_grade
    @roster.collect do |grade, students|
      {grade: grade, students: students}
    end .sort { |a, b| a[:grade] <=> b[:grade] }
  end
end
