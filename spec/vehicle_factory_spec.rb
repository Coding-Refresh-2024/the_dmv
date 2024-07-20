require 'spec_helper'

RSpec.describe VehicleFactory do

  before(:each) do
    @factory = VehicleFactory.new
    @wa_ev_registrations = DmvDataService.new.wa_ev_registrations
  end

  describe '#initialize' do
    it 'can initialize' do
      expect(@factory).to be_an_instance_of(VehicleFactory)
    end
  end

  describe '#create_vehicles' do
    it 'can create vehicle' do
      expect(@factory.create_vehicles(@wa_ev_registrations)).to be_an(Array)
      expect(@factory.create_vehicles(@wa_ev_registrations).count).to eq(1000)
      expect(@factory.create_vehicles(@wa_ev_registrations)[1]).to be_an(Vehicle)
    end
  end

end
