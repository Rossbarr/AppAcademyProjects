require "employee"

class Startup
    attr_reader(:name, :funding, :salaries, :employees)
    
    def initialize(name, funding, salaries)
        @name = name
        @funding = funding
        @salaries = salaries
        @employees = []
    end

    def valid_title?(str)
        @salaries.include?(str)
    end

    def >(company)
        @funding > company.funding
    end

    def hire(name, title)
        if valid_title?(title)
            @employees << Employee.new(name, title)
        else
            raise "Title does not exist."
        end
    end

    def size
        employees.length
    end

    def pay_employee(employee)
        if @funding >= @salaries[employee.title]
           employee.pay(@salaries[employee.title])
           @funding -= @salaries[employee.title]
        else
            raise "Not enough funding"
        end
    end
    
    def payday
        employees.each { |e| pay_employee(e) }
    end

    def average_salary
        employees.map { |e| @salaries[e.title] }.sum/employees.length
    end

    def close
        @employees = []
        @funding = 0
    end

    def acquire(company)
        @funding += company.funding
        company.salaries.each do |k,v|
            if !@salaries.key?(k)
                @salaries[k] = v
            end
        end
        company.employees.each { |e| @employees << e }
        company.close
    end
end
