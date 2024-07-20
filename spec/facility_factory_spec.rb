require './lib/spec_helper'

RSpec.describe FacilityFactory do

  before(:each) do
    @facility = FacilityFactory.new
    @ny = DmvDataService.new.ny_dmv_office_locations
    @mo = DmvDataService.new.mo_dmv_office_locations
  end

  describe '#initialize' do

  end

end
