# frozen_string_literal: true

require 'nokogiri'

module Parser
  module Atom
    module_function

    def parse(source)
      parsed_xml = Nokogiri::XML(source, &:noblanks)

      {
        info: channel_info(parsed_xml),
        items: item_parser(parsed_xml)
      }
    end

    def channel_info(parsed_xml)
      {
        title: parsed_xml.xpath('//rss/channel/title').text,
        description: parsed_xml.xpath('//rss/channel/description').text,
        link: parsed_xml.xpath('//rss/channel/link').text,
        web_master: parsed_xml.xpath('//rss/channel/webMaster').text
      }
    end

    def item_parser(parsed_xml)
      parsed_xml.xpath('//rss/channel/item').inject([]) do |items, item|
        items.push(
          title: item.xpath('title').text,
          description: item.xpath('description').text,
          date: item.xpath('pubDate').text,
          link: item.xpath('link').text,
          guid: {
            value: item.xpath('guid').text,
            permalink: item.xpath('guid').attribute('isPermaLink').value
          }
        )
      end
    end
  end
end
