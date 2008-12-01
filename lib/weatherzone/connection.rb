module Weatherzone  
  class Connection
    include Singleton

    attr_accessor :username, :password, :keygen
    
    def initialize
      @logger       = Logger.new(STDOUT)
      @logger.level = Logger::DEBUG
    end
  
    def key
      @keygen.call
    end
  
    def request(params)
      url = "http://webservice.theweather.com.au/ws1/wx.php?u=#{username}&k=#{key}&#{params}"
      @logger.debug(url)
      open(url) { |f| Hpricot.XML(f) }      
    end
  end
end