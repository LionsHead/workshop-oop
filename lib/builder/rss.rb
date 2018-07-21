# frozen_string_literal: true

require 'nokogiri'

module Builder
  module Rss
    module_function

    def build(data)
      convert(data[:channel], data[:items]).to_xml
    end

    def convert(channel_info, feed_items)
      Nokogiri::XML::Builder.new(encoding: 'UTF-8') do |xml|
        xml.rss(version: '2.0') do
          xml.channel do
            xml.title channel_info[:title]
            xml.description channel_info[:description]
            xml.link channel_info[:link]
            xml.webMaster channel_info[:web_master]

            feed_items.each do |item|
              xml.item do
                xml.title item[:title]
                xml.guid('isPermaLink' => item[:guid][:permalink]) { item[:guid][:value] }
                xml.link item[:link]
                xml.description item[:description]
                xml.pubDate item[:date]
              end
            end
          end
        end
      end
    end
  end
end
