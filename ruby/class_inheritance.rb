class Employee
  attr_accessor(:name, :title, :salary, :boss)

  def initialize(name, salary, title, boss)
    @name = name
    @title = title
    @salary = salary
    @boss = boss
  end

  def bonus(multiplier)
    return @salary * multiplier
  end

  def inspect
    p "Name: #{@name}, Title: #{@title}"
  end
end

class Manager < Employee
  def initialize(name, salary, title, boss, sub_employees)
    super(name, salary, title, boss)
    @sub_employees = sub_employees
  end

  def bonus(multiplier)
    sum = 0
    @sub_employees.each do |employee|
      sum += employee.bonus(1)
      if employee.class == Manager
        sum += employee.salary
      end
    end

    return sum*multiplier
  end
end

if __file__ = $PROGRAM_NAME
  david = Employee.new("David", 10000, "TA", "Darren")
  shawna = Employee.new("Shawna", 12000, "TA", "Darren")
  darren = Manager.new("Darren", 78000, "TA Manager", "Ned", [david, shawna])
  ned = Manager.new("Ned", 1000000, "Founder", nil, [darren])
  p ned.bonus(5)
  p darren.bonus(4)
  p david.bonus(3)
end
