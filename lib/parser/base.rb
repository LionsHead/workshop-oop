# frozen_string_literal: true

require 'nokogiri'
require 'require_all'

class Parser
  class Base
    attr_accessor :parsers

    def initialize(parsers)
      @parsers = parsers
    end

    def parse(source)
      parsed_xml = Nokogiri::XML(source, &:noblanks)
      parser = parsers.find { |kind| kind.required?(parsed_xml) }

      parser.new.parse(parsed_xml)
    end
  end
end
