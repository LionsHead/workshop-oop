# frozen_string_literal: true

require 'nokogiri'
require 'require_all'

class Parser
  class Xml
    attr_accessor :parsers

    def initialize(parsers)
      @parsers = parsers
    end

    def parse(source)
      # wip
      # parsed_xml = Nokogiri::XML(source, &:noblanks)
      # parsers.find { |kind| kind.required?(parsed_xml) }

      parser = parsers.last
      parser.new.parse(source)
    end
  end
end
