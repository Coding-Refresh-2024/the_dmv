class Registrant

  attr_reader :name, :age, :permit
  alias_method :permit?, :permit

  def initialize(name, age, permit = false)
    @name = name
    @age = age
    @permit = permit
  end

end
