require 'singleton'

module Weatherzone  
  
  class RequestFailed < Exception
    attr_reader :message
    def initialize(url)
      @message = "Failed to retreive #{url} and no cached version available"
    end
  end
  
  class Connection

    DEFAULT_TIMEOUT_AFTER = 1

    include Singleton

    attr_accessor :username, :password, :keygen, :cache, :logger, :timeout_after
    
    def initialize
      @logger       = Logger.new(STDOUT)
      @logger.level = Logger::DEBUG
    end
    
    def self.connect(username=nil, password=nil, options={}, &block)
      connection               = Weatherzone::Connection.instance
      connection.username      = username
      connection.password      = password
      connection.keygen        = block
      connection.logger        = options[:logger]
      connection.cache         = options[:cache]
      connection.timeout_after = options[:timeout_after] || DEFAULT_TIMEOUT_AFTER
    end
  
    def key
      @keygen.call
    end
    
    def base_url
      "http://webservice.theweather.com.au/ws1/wx.php?u=#{username}&k=#{key}"
    end
    
    def wz_url_for(params)
      "#{base_url}&#{params}"
    end
    
    def request(params)
      url = wz_url_for(params)
      debug("GET #{url}")
      timeout(self.timeout_after) do
        response = OpenURI::open(url)
        cache.write(params, response) if cache
        response.read
      end
    rescue Timeout::Error, SocketError
      debug("webservice connection failed, reading from cache")
      cache ? (cache.read(params) || raise(RequestFailed.new(url))) : raise(RequestFailed.new(url))
    end
    
    def debug(message)
      @logger.debug("[weatherzone] #{message}") if @logger
    end

    def error(message)
      @logger.error("[weatherzone] #{message}") if @logger
    end

  end
end