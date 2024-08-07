class Registrant

  attr_reader :name, :age

  attr_accessor :license_data, :permit
  alias_method :permit?, :permit

  def initialize(name, age, permit = false)
    @name = name
    @age = age
    @permit = permit
    @license_data = {:written=>false, :license=>false, :renewed=>false}
  end

  def earn_permit
    @permit = true
  end

end
