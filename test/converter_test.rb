# frozen_string_literal: true

require_relative 'test_helper'

class ConverterTest < Minitest::Test
  def setup
    @source_file = 'test/fixtures/test_feed.xml'
    @options = {
      output: 'rss'
    }

    @source_url = 'http://example.io/feed.rss'
    @true_feed = File.read 'test/fixtures/true_rss.xml'
    stub_request(:get, 'example.io/feed.rss')
      .to_return(status: 200, headers: {}, body: @true_feed)

    @downloader = Downloader::Filesystem.new
  end

  def test_convert
    output = ConverterFeed.new.convert(@source_file)

    assert_equal output, @true_feed
  end

  def test_http_convert
    output = ConverterFeed.new.convert(@source_url)

    assert_equal output, @true_feed
  end

  def test_file
    source = @source_file
    fylesystem = Downloader::Filesystem
    network = Downloader::Http
    stdin = Downloader::Stdin

    assert fylesystem.usable?(source)
    assert !network.usable?(source)
    assert !stdin.usable?(source)
  end

  def test_http
    source = 'https://ru.hexlet.io/lessons.rss'
    fylesystem = Downloader::Filesystem
    network = Downloader::Http
    stdin = Downloader::Stdin

    assert !fylesystem.usable?(source)
    assert network.usable?(source)
    assert !stdin.usable?(source)
  end

  def test_empty_arguments
    source = nil
    fylesystem = Downloader::Filesystem
    network = Downloader::Http
    stdin = Downloader::Stdin

    assert !fylesystem.usable?(source)
    assert !network.usable?(source)
    assert !stdin.usable?(source)
  end

  def test_parsing
    source = @downloader.get(@source_file)
    parsers = [
      Parser::Rss
    ]
    parsed_info = Parser::Base.new(parsers).parse(source)

    channel = parsed_info[:info]
    assert channel[:description] == 'Практические уроки по программированию'
    assert channel[:link] == 'https://ru.hexlet.io/'

    assert !parsed_info[:items].empty?
  end
end
