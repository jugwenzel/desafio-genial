module BusinessRules
  ELIGIBLE_DIAGNOSES = ["A", "B", "C"]
  MAX_ELIGIBLE_AGE = 5
end

class Child
  include BusinessRules
  private attr_reader :age, :diagnosis

  def initialize (age, diagnosis = nil)
    @age = age
    @diagnosis = diagnosis
  end

  def eligible?
    if age <= MAX_ELIGIBLE_AGE && ELIGIBLE_DIAGNOSES.include?(diagnosis)
      return true 
    else
      return false 
    end
  end
end

a = Child.new(2)
b = Child.new(10)
c = Child.new(3,"A")
d = Child.new(3,"E")
e = Child.new(10,"B")

puts a.eligible?
puts b.eligible?
puts c.eligible?
puts d.eligible?
puts e.eligible?
