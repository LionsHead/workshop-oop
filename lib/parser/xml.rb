# frozen_string_literal: true

require 'nokogiri'
require 'require_all'
require_rel ''

class Parser
  class Xml
    attr_accessor :parsers

    def initialize(parsers)
      @parsers = parsers
    end

    def parse(source)
      # parsed_xml = Nokogiri::XML(source, &:noblanks)
      # parsers.find { |kind| kind.required?(parsed_xml) }

      Parser::Rss.new.parse(source)
    end
  end
end
