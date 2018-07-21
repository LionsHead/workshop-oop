# frozen_string_literal: true

require 'nokogiri'
require 'open-uri'

class ConverterFeed
  def initialize(options)
    @options = options
  end

  def run
    source_xml = by_source
    parsed_xml = parse(source_xml)

    channel_info = feed_info(parsed_xml)
    feed_items = feed_parser(parsed_xml)

    xml = builder_rss(channel_info, feed_items).to_xml

    output(xml)
  end

  def parse(source_xml)
    Nokogiri::XML(source_xml, &:noblanks)
  end

  def by_source
    open(@options[:source], &:read)
  end

  def feed_info(parsed_xml)
    {
      title: parsed_xml.xpath('//rss/channel/title').text,
      description: parsed_xml.xpath('//rss/channel/description').text,
      link: parsed_xml.xpath('//rss/channel/link').text,
      web_master: parsed_xml.xpath('//rss/channel/webMaster').text
    }
  end

  def feed_parser(parsed_xml)
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

  def builder_rss(channel_info, feed_items)
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

  def output(xml)
    pp xml
  end
end
