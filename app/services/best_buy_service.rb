class BestBuyService
  def initialize
    @_connection = Faraday.new(url: 'http://api.bestbuy.com') do |f|
      f.request  :url_encoded
      f.response :logger
      f.adapter  Faraday.default_adapter
    end
    set_params
  end

  def search_by_zip(zip)
    path = "/v1/stores(area(#{zip},25))"
    response_parser(get(path), :stores)
  end

  def individual_store(store_id)
    path = "/v1/stores(storeId=#{store_id})"
    response_parser(get(path), :stores).first
  end

  def get(path)
    connection.get do |req|
      req.url path
    end
  end

  private
  def connection
    @_connection
  end

  def set_params
    connection.params['apiKey'] = ENV['BEST_BUY_KEY']
    connection.params['format'] = 'json'
    connection.params['show'] = "longName,city,distance,phone,storeType,storeId,hoursAmPm,address,region,postalCode"
    connection.params['pageSize'] = 20
  end


  def response_parser(response, type)
    JSON.parse(response.body, symbolize_names: true)[type]
  end

end

# "https://api.bestbuy.com/v1/stores?format=json&show=city,longName&pageSize=2&apiKey=YourAPIKey"
