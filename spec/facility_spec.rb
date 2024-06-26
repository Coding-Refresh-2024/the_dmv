require 'spec_helper'

RSpec.describe Facility do
  before(:each) do
    @facility = Facility.new({name: 'DMV Tremont Branch', address: '2855 Tremont Place Suite 118 Denver CO 80205', phone: '(720) 865-4600'})
    @cruz = Vehicle.new({vin: '123456789abcdefgh', year: 2012, make: 'Chevrolet', model: 'Cruz', engine: :ice} )
    @bolt = Vehicle.new({vin: '987654321abcdefgh', year: 2019, make: 'Chevrolet', model: 'Bolt', engine: :ev} )
    @camaro = Vehicle.new({vin: '1a2b3c4d5e6f', year: 1969, make: 'Chevrolet', model: 'Camaro', engine: :ice} )
    @registrant1 = Registrant.new('Cory', 33, true)
    @registrant2 = Registrant.new('Abby', 15)
  end
  describe '#initialize' do
    it 'can initialize' do
      expect(@facility).to be_an_instance_of(Facility)
      expect(@facility.name).to eq('DMV Tremont Branch')
      expect(@facility.address).to eq('2855 Tremont Place Suite 118 Denver CO 80205')
      expect(@facility.phone).to eq('(720) 865-4600')
      expect(@facility.services).to eq([])
      expect(@facility.registered_vehicles).to eq([])
      expect(@facility.collected_fees).to eq(0)
    end
  end

  describe '#add service' do
    it 'can add available services' do
      expect(@facility.services).to eq([])
      @facility.add_service('New Drivers License')
      @facility.add_service('Renew Drivers License')
      @facility.add_service('Vehicle Registration')
      expect(@facility.services).to eq(['New Drivers License', 'Renew Drivers License', 'Vehicle Registration'])
    end
  end

  describe '#register vehicle' do
    it "verifies that the facility can register vehicles or not" do
      expect(@facility.registered_vehicles).to eq([])
      expect(@facility.register_vehicle(@cruz)).to eq("This facility is not able to register vehicles at this time.")

      @facility.add_service('Vehicle Registration')
      @facility.register_vehicle(@cruz)

      expect(@facility.registered_vehicles).to eq([@cruz])
    end

    it "can add a vehicle to a facilities registered vehicle attribute" do
      @facility.add_service('Vehicle Registration')
      expect(@facility.registered_vehicles).to eq([])
      @facility.register_vehicle(@cruz)
      expect(@facility.registered_vehicles).to eq([@cruz])
    end

    it "updates the vehicles registration date attribute" do
      @facility.add_service('Vehicle Registration')
      expect(@cruz.registration_date).to eq(nil)
      @facility.register_vehicle(@cruz)
      expect(@cruz.registration_date).to eq(Date.today)
    end

    it "updates the vehicles plate type to one of three types" do
      @facility.add_service('Vehicle Registration')
      expect(@cruz.plate_type).to eq(nil)
      @facility.register_vehicle(@cruz)
      expect(@cruz.plate_type).to eq(:regular)

      expect(@bolt.plate_type).to eq(nil)
      @facility.register_vehicle(@bolt)
      expect(@bolt.plate_type).to eq(:ev)

      expect(@camaro.plate_type).to eq(nil)
      @facility.register_vehicle(@camaro)
      expect(@camaro.plate_type).to eq(:antique)
    end

    it "updates the facility @collected_fees attribute when a vehicle is registered" do
      @facility.add_service('Vehicle Registration')
      expect(@facility.collected_fees).to eq(0)
      @facility.register_vehicle(@cruz)
      expect(@facility.collected_fees).to eq(100)

      @facility.register_vehicle(@bolt)
      expect(@facility.collected_fees).to eq(300)

      @facility.register_vehicle(@camaro)
      expect(@facility.collected_fees).to eq(325)
    end
  end

  describe '#administer_written_test' do
    it "verifies that the facility offers written test services" do
      expect(@facility.administer_written_test(@registrant1)).to eq("This facility does not current administer written tests.")

      @facility.add_service('Written Test')

      expect(@facility.administer_written_test(@registrant1)).to_not eq("This facility does not current administer written tests.")
    end

    it "verifies that the applicant has a permit and is of age(over 15) to take the written test" do
      @facility.add_service('Written Test')

      expect(@facility.administer_written_test(@registrant1)).to_not eq('This registrant is not eligible to take the written test.')
      expect(@facility.administer_written_test(@registrant2)).to eq('This registrant is not eligible to take the written test.')

    end

    it "updates the registrants license_data[:written] to true" do
      @facility.add_service('Written Test')

      expect(@registrant1.license_data[:written]).to eq(false)

      @facility.administer_written_test(@registrant1)

      expect(@registrant1.license_data[:written]).to eq(true)
    end
  end
end
