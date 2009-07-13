require 'singleton'

module Weatherzone  
  
  class RequestFailed < Exception
    attr_reader :message
    def initialize(url)
      @message = "Failed to retreive #{url} and no cached version available"
    end
  end
  
  class Settings
    include Singleton
    attr_accessor :strip_scale_from_units
  end
  
  class Connection

    DEFAULT_TIMEOUT_AFTER = 1

    include Singleton

    attr_accessor :username, :password, :keygen, :logger, :timeout_after
    
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
      connection.timeout_after = options[:timeout_after] || DEFAULT_TIMEOUT_AFTER
    end
  
    def self.settings
      Weatherzone::Settings.instance
    end
  
    def key
      @keygen.call
    end
    
    def base_url
      "http://webservice.theweather.com.au/ws1/wx.php?u=#{username}&k=#{key}"
    end
    
    def wz_url_for(params)
      "#{base_url}#{params}"
    end
    
    def request(params)
      url = wz_url_for(params)
      debug("GET #{url}")
      timeout(self.timeout_after) do
        response = OpenURI::open(url)
        response.read
      end
    rescue Timeout::Error, SocketError
      debug("webservice connection failed")
      raise RequestFailed.new(url)
    end
    
    def debug(message)
      @logger.debug("[weatherzone] #{message}") if @logger
    end

    def error(message)
      @logger.error("[weatherzone] #{message}") if @logger
    end

  end
end