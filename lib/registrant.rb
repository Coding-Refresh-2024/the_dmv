class Registrant

  attr_reader :name, :age, :permit, :license_data
  alias_method :permit?, :permit

  def initialize(name, age, permit = false)
    @name = name
    @age = age
    @permit = permit
    @license_data = {:written=>false, :license=>false, :renewed=>false}
  end

end
