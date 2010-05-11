module Hancock
  class Consumer
    include DataMapper::Resource

    property :id,           Serial
    property :url,          String,  :required => true, :unique => true, :unique_index => true, :length => 2048
    property :label,        String,  :required => false
    property :internal,     Boolean, :required => false, :default => false

    def self.allowed?(host)
      !first(:url => host).nil?
    end

    def self.visible
      all(:internal => false).select do |c|
        c.label
      end
    end

    def self.internal
      all(:internal => true).select do |c|
        c.label
      end
    end
  end
end
