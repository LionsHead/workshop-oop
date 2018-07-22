# frozen_string_literal: true

class Parser
  class Rss
    def self.required?(xml)
      !!xml.at_xpath('/rss')
    end

    def parse(parsed_xml)
      {
        info: channel_info(parsed_xml),
        items: item_parser(parsed_xml)
      }
    end

    def channel_info(parsed_xml)
      {
        title: parsed_xml.xpath('//rss/channel/title').text,
        description: parsed_xml.xpath('//rss/channel/description').text,
        link: parsed_xml.xpath('//rss/channel/link').text
      }
    end

    def item_parser(parsed_xml)
      parsed_xml.xpath('//rss/channel/item').inject([]) do |items, item|
        items.push(
          title: item.xpath('title').text,
          description: item.xpath('description').text,
          date: item.xpath('pubDate').text,
          link: item.xpath('link').text
        )
      end
    end
  end
end
