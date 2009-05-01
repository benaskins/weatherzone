require 'open-uri'

module Kernel
  private 
  alias openuri_original_open open
  def open(name, *rest, &block)
    if name.respond_to?(:open)
      name.open(*rest, &block)
    elsif name.respond_to?(:to_str) &&
          %r{\A[A-Za-z][A-Za-z0-9+\-\.]*://} =~ name &&
          (uri = URI.parse(name)).respond_to?(:open)
      OpenURI::open(name, *rest, &block)
    else
      open_uri_original_open(name, *rest, &block)
    end
  end
  module_function :open, :openuri_original_open
end

module OpenURI
  alias original_open open #:nodoc:
  def self.open(uri, *rest, &block)
    if Cache.enabled?
      response = Cache.get(Cache.key_for(uri))
    end
    
    unless response
      response = openuri_original_open(uri, *rest).read
      Cache.set(Cache.key_for(uri), response) if Cache.enabled?
    end

    response = StringIO.new(response)

    if block_given?
      begin
        yield response
      ensure
        response.close
      end
    else
      response
    end
  end
  
  class Cache

    class KeyHash
      def self.enable!
        @hash_keys = true
      end
      
      def self.disable!
        @hash_keys = false
      end

      def self.enabled?
        @hash_keys
      end
      
      def self.disabled?
        !@hash_keys
      end
      
      def self.generate(uri)
        Digest::MD5.hexdigest(uri)
      end
    end
    
    # Cache is not enabled by default
    @cache_enabled = false
    
    class << self
      attr_writer :expiry, :host
      
      # Is the cache enabled?
      def enabled?
        @cache_enabled
      end
      
      # Enable caching
      def enable!
        raise NotImplementedError
      end
      
      # Disable caching - all queries will be run directly 
      # using the standard OpenURI `open` method.
      def disable!
        @cache_enabled = false
      end

      def disabled?
        !@cache_enabled
      end
      
      def get(key)
        raise NotImplementedError
      end
      
      def set(key, value)
        raise NotImplementedError
      end
            
      def key_for(uri)
        Cache::KeyHash.enabled? ? Cache::KeyHash.generate(uri.to_s) : uri.to_s
      end      
      
      # How long your caches will be kept for (in seconds)
      def expiry
        @expiry ||= 60 * 10
      end
      
      def host
        @host ||= "127.0.0.1:11211"
      end
    end
  end
end