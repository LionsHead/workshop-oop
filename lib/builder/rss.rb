# frozen_string_literal: true

require 'nokogiri'

module Builder
  module Rss
    module_function

    def build(data)
      convert(data).to_xml
    end

    def convert(data)
      Nokogiri::XML::Builder.new(encoding: 'UTF-8') do |xml|
        xml.rss(version: '2.0') do
          channel(xml, data)
        end
      end
    end

    def channel(xml, data)
      info = data[:info]
      feed_items = data[:items]

      xml.channel do
        xml.title info[:title]
        xml.description info[:description]
        xml.link info[:link]
        xml.webMaster info[:web_master]

        items(xml, feed_items) if feed_items
      end
    end

    def items(xml, feed_items)
      feed_items.each do |item|
        xml.item do
          xml.title item[:title]
          guid(xml, item)
          xml.link item[:link]
          xml.description item[:description]
          xml.pubDate item[:date]
        end
      end
    end

    def guid(xml, item)
      xml.guid('isPermaLink' => item[:guid][:permalink]) { item[:guid][:value] }
    end
  end
end