# frozen_string_literal: true

# wip смотри rss
require 'nokogiri'

# simple feed
#  <?xml version="1.0" encoding="utf-8"?>
# <feed xmlns="http://www.w3.org/2005/Atom">
#
#   <title>Example Feed</title>
#   <link href="http://example.org/"/>
#   <updated>2003-12-13T18:30:02Z</updated>
#   <author>
#     <name>John Doe</name>
#   </author>
#   <id>urn:uuid:60a76c80-d399-11d9-b93C-0003939e0af6</id>
#
#   <entry>
#     <title>Atom-Powered Robots Run Amok</title>
#     <link href="http://example.org/2003/12/13/atom03"/>
#     <id>urn:uuid:1225c695-cfb8-4ebb-aaaa-80da344efa6a</id>
#     <updated>2003-12-13T18:30:02Z</updated>
#     <summary>Some text.</summary>
#   </entry>
#
# </feed>

class Converter
  class Atom
    def converter(data)
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
        xml.autor info[:web_master]

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
