module Weatherzone  
  
  class RequestFailed < Exception
    attr_reader :message
    def initialize(url)
      @message = "Failed to retreive #{url} and no cached version available"
    end
  end
  
  class Connection
    include Singleton

    attr_accessor :username, :password, :keygen, :cache, :logger
    
    def initialize
      @logger       = Logger.new(STDOUT)
      @logger.level = Logger::DEBUG
    end
    
    def self.connect(username=nil, password=nil, options={}, &block)
      connection          = Weatherzone::Connection.instance
      connection.username = username
      connection.password = password
      connection.keygen   = block
      connection.logger   = options[:logger] || Logger.new(STDOUT)
      connection.cache    = options[:cache]
    end
  
    def key
      @keygen.call
    end
    
    def wz_url_for(params)
      "http://webservice.theweather.com.au/ws1/wx.php?u=#{username}&k=#{key}&#{params}"
    end
    
    def request(params)
      url = wz_url_for(params)
      debug("GET #{url}")
      timeout(1) do
        doc = open(url) { |f| Hpricot.XML(f) }
        cache ? cache.write(params, doc) : doc
      end
    rescue Timeout::Error, SocketError
      debug("webservice connection failed, reading from cache")
      cache ? (cache.read(params) || raise(RequestFailed.new(url))) : raise(RequestFailed.new(url))
    end
    
    def debug(message)
      @logger.debug("[weatherzone] #{message}")
    end

    def error(message)
      @logger.error("[weatherzone] #{message}")
    end

  end
end