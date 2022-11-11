class Child
  @@id = 1
  attr_reader :id
  attr_accessor :name, :age, :diagnosis, :health_plan, :caregivers, :caregiver_id

  def initialize(name, age, diagnosis = false, health_plan = nil)
    @name = name
    @age = age
    @diagnosis = diagnosis
    @health_plan = health_plan
    @caregivers = 0
    @id = @@id
    @@id += 1
    @caregiver_id = []
  end
end

class Caregiver
  @@id = 1
  attr_reader :child_id
  attr_accessor :name, :income, :employed

  def initialize(child, name, income, employed)
    @child_id = child.id
    child.caregivers += 1
    child.caregiver_id << @@id
    @name = name
    @income = income
    @employed = employed
    @@id += 1
  end
end

class BusinessRulesValidation
  MAX_ELIGIBLE_AGE = 5
  MIN_INCOME = 10000 #in case of particular payment
  ELIGIBLE_HEALTH_PLANS = ["Alice", "GNDI"]
  EMPLOYED_CARETAKERS = 2

  def eligible_age?(child)
    return true if child.age <= MAX_ELIGIBLE_AGE
    return false
  end

  def eligible_health_plan?(child)
    return true if ELIGIBLE_HEALTH_PLANS.include?(child.health_plan)
  end

  def eligible_income_amount(child)
    sum_income = 0

    caregivers = Caregiver.all.filter do |caregiver|
      caregiver.id == child.caregiver_id
    end

    caregivers.each do |caregiver|
      sum_income = sum_income + caregiver.income
    end
  end

  def eligible_employment_status?(child)
    employed_caregivers = 0

    caregivers = Caregiver.all.filter do |caregiver|
      caregiver.id == child.caregiver_id

      caregivers.each do |caregiver|
        if caregiver.employed == 0
          employed_caregivers += 1
        end
        
        return true if employed_caregivers == 2
      end
    end
    
  end

  def eligible?(child)
    return eligible_age?(child) && (eligible_health_plan?(child) || eligible_income_amount(child)) && eligible_employment_status(child)?
  end
end

class Main
  def execute
    maria = Child.new("Maria", 10, true, "Alice")
    pedro = Caregiver.new(maria, "Jose", 4000, true)
    regina = Caregiver.new(maria, "Regina", 6000, true)

    puts BusinessRulesValidation.new.eligible_age?(maria)
    puts BusinessRulesValidation.new.eligible_health_plan?(maria)
    puts BusinessRulesValidation.new.eligible_employment_status?(maria)
    puts maria.caregiver_id

    puts "O nome é da criança #{maria.name}. Ela tem #{maria.age} anos e usa o plano
    #{maria.health_plan}.\nEla possui #{maria.caregivers} cuidadores. Os nomes são: #{}"
  end
end

Main.new.execute