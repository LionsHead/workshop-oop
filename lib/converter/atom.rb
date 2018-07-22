# frozen_string_literal: true

# wip see rss
require 'nokogiri'

class Converter
  class Atom
    def render(data)
      data
    end

    def convert(data)
      Nokogiri::XML::Builder.new(encoding: 'UTF-8') do |xml|
        xml.feed(xmlns: 'http://www.w3.org/2005/Atom') do
          feed(xml, data)
        end
      end
    end

    def feed(xml, data)
      info = data[:info]
      feed_items = data[:items]

      xml.channel do
        xml.title info[:title]
        xml.description info[:description]
        xml.link info[:link]
        # xml.autor info[:web_master]

        items(xml, feed_items) if feed_items
      end
    end

    def items(xml, feed_items)
      feed_items.each do |item|
        xml.entry do
          xml.title item[:title]
          xml.link item[:link]
          xml.description item[:description]
          xml.pubDate item[:date]
        end
      end
    end
  end
end
