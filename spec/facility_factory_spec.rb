require 'spec_helper'

RSpec.describe FacilityFactory do

  before(:each) do
    @facility = FacilityFactory.new
    @ny = DmvDataService.new.ny_dmv_office_locations
    @mo = DmvDataService.new.mo_dmv_office_locations
  end

  describe '#initialize' do
    it "can initalize" do
      expect(@facility).to be_an_instance_of(FacilityFactory)
    end
  end

  describe '#create_facilities' do
    it "creates facilities" do
      ny_fac = @facility.create_facilities(@ny)
      mo_fac = @facility.create_facilities(@mo)

      expect(ny_fac).to be_an(Array)
      expect(ny_fac.count).to eq(170)
      expect(mo_fac).to be_an(Array)
      expect(mo_fac.count).to eq(178)
    end
  end

end
