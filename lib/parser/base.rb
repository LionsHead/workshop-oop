# frozen_string_literal: true

require 'nokogiri'
require 'require_all'

class Parser
  class Base
    attr_reader :parsers

    def initialize(parsers)
      @parsers = parsers
    end

    def parse(source)
      parsed_xml = Nokogiri::XML(source, &:noblanks)
      parsed_xml.remove_namespaces!

      parser = parsers.find { |kind| kind.required?(parsed_xml) }

      parser.new.parse(parsed_xml)
    end
  end
end
