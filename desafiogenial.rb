class Child
  attr_accessor :caregiver1, :caregiver2, :name, :age, :diagnosis, :health_plan

  def initialize(caregiver1, caregiver2, name, age, diagnosis = false, health_plan = nil)
    @caregiver1 = caregiver1
    @caregiver2 = caregiver2
    @name = name
    @age = age
    @diagnosis = diagnosis
    @health_plan = health_plan
  end
end

class Caregiver
  attr_accessor :name, :income, :employed

  def initialize(name, income, employed)
    @name = name
    @income = income
    @employed = employed
  end
end

class BusinessRulesValidation
  MAX_ELIGIBLE_AGE = 5
  MIN_INCOME = 10000 #in case of particular payment
  ELIGIBLE_HEALTH_PLANS = ["Alice", "GNDI"]
  EMPLOYED_CARETAKERS = 2

  def eligible_age?(child)
    child.age <= MAX_ELIGIBLE_AGE
  end

  def eligible_health_plan?(child)
    ELIGIBLE_HEALTH_PLANS.include?(child.health_plan)
  end

  def eligible_income_amount?(child)
    child.caregiver1.income + child.caregiver2.income >= MIN_INCOME
  end

  def eligible_employment_status?(child)
    child.caregiver1.employed && child.caregiver2.employed
  end

  def eligible?(child)
    eligible_age?(child) && 
    (eligible_health_plan?(child) || (eligible_income_amount?(child) && eligible_employment_status?(child)))
  end

end

class Main
  def execute
    pedro = Caregiver.new("Jose", 4000, false)
    regina = Caregiver.new("Regina", 7000, true)
    maria = Child.new(pedro, regina, "Maria", 2, true)

    puts BusinessRulesValidation.new.eligible_age?(maria)
    puts BusinessRulesValidation.new.eligible_health_plan?(maria)
    puts BusinessRulesValidation.new.eligible_income_amount?(maria)
    puts BusinessRulesValidation.new.eligible_employment_status?(maria)
    puts BusinessRulesValidation.new.eligible?(maria)

  end
end

Main.new.execute