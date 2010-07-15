require 'eg.helper'

require 'weatherzone/resources/weather'

eg.setup do
  @mapper = HttpVanilli.use_basic_mapper!(HttpVanilli::Responders::Block)

  keygen = lambda { 'xxxx'+password }
  @connection = Weatherzone::Connection.new('theuser', 'thepass', keygen, :url => 'http://wz.com/ws.php', :timeout_after => 10)
end

eg 'the basic connection' do
  @mapper.add_responder {|req|
    if req.method == :get && req.uri.host == 'wz.com' && req.uri.path == '/ws.php' && req.uri.query_values['lc'] == '9770'
      respond_with('everything')
    end
  }

  weather = Weather.find_by_location_code(@connection, "9770")
  country = weather.countries.first

  Assert( country.name == 'Australia' )
  Assert( country.code == 'AU' )
end
