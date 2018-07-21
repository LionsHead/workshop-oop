# frozen_string_literal: true

require_relative 'test_helper'

class TestConverter < Minitest::Test
  def setup
    @options = {
      source: 'test/fixtures/test_feed.xml'
    }
  end

  def test_input_type
    source = @options[:source]

    kinds = [
      Downloader::Http.new(source),
      Downloader::Filesystem.new(source),
      Downloader::Stdin.new(source)
    ]

    assert kinds.find(&:usable?).is_a?(Downloader::Filesystem)
  end

  def test_converted_file
    output = ConverterFeed.new(@options).convert
    parsed = Nokogiri::XML(output, &:noblanks)

    description = parsed.xpath('//rss/channel/description').text
    link = parsed.xpath('//rss/channel/link').text

    assert description == 'Практические уроки по программированию'
    assert link == 'https://ru.hexlet.io/'
  end
end
