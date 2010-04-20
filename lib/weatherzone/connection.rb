require 'singleton'

module Weatherzone  
  
  class RequestFailed < Exception
    attr_reader :message, :original_exception
    def initialize(url, original_exception)
      @message   = "Failed to retreive #{url} and no cached version available"
      @original_exception = original_exception
    end
  end
  
  class Settings
    include Singleton
    attr_accessor :strip_scale_from_units, :weather_class
  end
  
  class Connection

    DEFAULT_TIMEOUT_AFTER = 1

    include Singleton

    attr_accessor :username, :password, :url, :keygen, :logger, :timeout_after
    
    def initialize
      @logger       = Logger.new(STDOUT)
      @logger.level = Logger::DEBUG
    end
    
    def self.connect(username=nil, password=nil, options={}, &block)
      connection               = Weatherzone::Connection.instance
      connection.username      = username
      connection.password      = password
      connection.url           = options[:url]
      connection.keygen        = block
      connection.logger        = options[:logger]
      connection.timeout_after = options[:timeout_after] || DEFAULT_TIMEOUT_AFTER
    end
  
    def self.settings
      Weatherzone::Settings.instance
    end
    
    def settings
      self.class.settings
    end
  
    def key
      @keygen.call
    end
    
    def base_url
      @base_url ||= "#{self.url}?u=#{username}&k=#{key}"
    end
    
    def wz_url_for(params)
      "#{base_url}#{params}"
    end
    
    def request(params)
      url = wz_url_for(params)
      info("GET #{url}")
      timeout(self.timeout_after) do
        response = OpenURI::open(url)
        response.read
      end
    rescue Timeout::Error, SocketError => e
      error("webservice connection failed #{e}")
      raise RequestFailed.new(url, e)
    end
    
    def debug(message) 
      @logger.debug("[weatherzone] [DEBUG] #{message}") if @logger
    end

    def info(message)
      @logger.info("[weatherzone] [INFO] #{message}") if @logger
    end

    def error(message)
      @logger.error("[weatherzone] [ERROR] #{message}") if @logger
    end
   
  end
end