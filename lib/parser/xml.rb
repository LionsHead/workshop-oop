# frozen_string_literal: true

require 'nokogiri'

class Parser
  class Xml
    attr_reader :parsers

    def initialize(parsers)
      @parsers = parsers
    end

    def parse(source)
      parsed_xml = Nokogiri::XML(source, &:noblanks)
      parsers.find { |kind| kind.required?(parsed_xml) }
    end
  end
end
