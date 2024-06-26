class Facility
  attr_reader :name,
              :address,
              :phone,
              :services,
              :registered_vehicles

  attr_accessor :collected_fees

  def initialize(hash)
    @name = hash[:name]
    @address = hash[:address]
    @phone = hash[:phone]
    @services = []
    @registered_vehicles = []
    @collected_fees = 0
  end

  def add_service(service)
    @services << service
  end

  def register_vehicle(vehicle)
    if self.services.include?('Vehicle Registration')

      @registered_vehicles << vehicle

      vehicle.registration_date = Date.today

      if vehicle.antique?
        vehicle.plate_type = :antique
        self.collected_fees += 25
      elsif vehicle.electric_vehicle?
        vehicle.plate_type = :ev
        self.collected_fees += 200
      else
        vehicle.plate_type = :regular
        self.collected_fees += 100
      end

    else
      "This facility is not able to register vehicles at this time."
    end
  end

  def administer_written_test(registrant)
    if self.services.include?('Written Test')

      if registrant.age >=16 && registrant.permit? == true
        registrant.license_data[:written] = true
      else
        'This registrant is not eligible to take the written test.'
      end

    else
      "This facility does not current administer written tests."
    end
  end

  def administer_road_test(registrant)
    if self.services.include?('Road Test')

      if registrant.license_data[:written] == true
        registrant.license_data[:license] = true
      else
        'This registrant is not eligible to take the road test.'
      end
    else
      'This facility does not currently administer road tests.'
    end
  end

  def renew_drivers_license(registrant)
    if self.services.include?('Renew License')

      if registrant.license_data[:license] == true

      else
        'This registrant is not eligible for license renewal.'
      end

    else
      "This facility does not currently renew licenses."
    end
  end

end
