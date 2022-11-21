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


class AgeValidation
  MAX_ELIGIBLE_AGE = 5

  attr_accessor :child, :next_validation

  def initialize(child, next_validation = FinalValidation.new)
    @child = child
    @next_validation = next_validation
  end

  def valid?
    return next_validation.valid? if child.age <= MAX_ELIGIBLE_AGE
    fail "Age not valid"
  end
end

class ResourcesValidation
  ELIGIBLE_HEALTH_PLANS = ["Alice", "GNDI"]
  MIN_INCOME = 10000 #in case of particular payment

  attr_accessor :child, :next_validation

  def initialize(child, next_validation = FinalValidation.new)
    @child = child
    @next_validation = next_validation
  end

  def valid?
    return next_validation.valid? if ELIGIBLE_HEALTH_PLANS.include?(child.health_plan) || child.caregiver1.income + child.caregiver2.income >= MIN_INCOME
    fail "Health plan or income amount not valid"
  end
end

class EmploymentStatusValidation
  attr_accessor :child, :next_validation

  def initialize(child, next_validation = FinalValidation.new)
    @child = child
    @next_validation = next_validation
  end

  def valid?
    return next_validation.valid? if child.caregiver1.employed && child.caregiver2.employed
    fail "Both caregivers must be employed"
  end
end

class FinalValidation
  def valid?
    puts "Valid"
    return true
  end
end

pedro = Caregiver.new("Jose", 2000, true)
regina = Caregiver.new("Regina", 7000, true)

maria = Child.new(pedro, regina, "Maria", 2, true)

chain =  AgeValidation.new(maria, ResourcesValidation.new(maria, EmploymentStatusValidation.new(maria)))

chain.valid?

