require 'spec_helper'

RSpec.describe Registrant do

  before(:each) do
    @registrant1 = Registrant.new('Cory', 33, true)
    @registrant2 = Registrant.new('Abby', 15)
  end

  it 'creates an instance of Registrant and has readable attributes' do
    expect(@registrant1).to be_an_instance_of(Registrant)
    expect(@registrant1.name).to eq('Cory')
    expect(@registrant1.age).to eq(33)
    expect(@registrant1.permit?).to eq(true)
    expect(@registrant2.permit?).to eq(false)
    expect(@registrant2.license_data).to eq({:written=>false, :license=>false, :renewed=>false})

  end

end
