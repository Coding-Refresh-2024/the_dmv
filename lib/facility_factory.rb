class FacilityFactory

  def initalize

  end

  def create_facilities(source)
    all_facilities = []

    source.each do |hash|
      if hash[:state] == 'NY'
        all_facilities << Facility.new({name: hash[:office_name],
                                        address: hash[:street_address_line_1],
                                        phone: hash[:public_phone_number]
          })

      elsif hash[:state] == 'MO'
        all_facilities << Facility.new({name: hash[:name],
                                        address: hash[:address1],
                                        phone: hash[:phone]
          })
      end
    end
    all_facilities
  end

end
