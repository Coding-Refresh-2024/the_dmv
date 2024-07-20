class VehicleFactory

  def initalize

  end

  def create_vehicles(source)
    all_vehicles = []

    source.each do |hash|
      all_vehicles << Vehicle.new({vin: hash[:vin_1_10],
                   year: hash[:model_year],
                   make: hash[:make],
                   model: hash[:model],
                   engine: :ev})
    end

    return all_vehicles
  end


end
