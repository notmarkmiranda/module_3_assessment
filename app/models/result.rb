class Result
  attr_reader :long_name, :city, :distance, :phone_number, :store_type, :store_id, :address, :state, :zip, :hours

  def initialize(data)
    @long_name = data[:longName]
    @city = data[:city]
    @distance = data[:distance]
    @phone_number = data[:phone]
    @store_type = data[:storeType]
    @store_id = data[:storeId]
    @address = data[:address]
    @state = data[:region]
    @zip = data[:postalCode]
    @hours = data[:hoursAmPm]
  end

  def self.single_store(store_id)
    Result.new(bby_service.individual_store(store_id))
  end

  def self.find_stores(zip)
    bby_service.search_by_zip(zip).map do |data|
      Result.new(data)
    end
  end

  private

  def self.bby_service
    BestBuyService.new
  end

end
