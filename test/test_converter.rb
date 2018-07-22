# frozen_string_literal: true

require_relative 'test_helper'

class TestConverter < Minitest::Test
  def setup
    @source = 'test/fixtures/test_feed.xml'
    @options = {
      output: 'rss'
    }

    @downloader = Downloader::Filesystem.new
  end

  def test_convert
    output = ConverterFeed.new.convert(@source)
    true_feed = File.read 'test/fixtures/true_rss.xml'

    assert_equal output, true_feed
  end

  def test_file
    source = @source
    fylesystem = Downloader::Filesystem
    network = Downloader::Http

    assert fylesystem.usable?(source)
    assert !network.usable?(source)
  end

  def test_http
    source = 'https://ru.hexlet.io/lessons.rss'
    fylesystem = Downloader::Filesystem
    network = Downloader::Http

    assert !fylesystem.usable?(source)
    assert network.usable?(source)
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
    source = @downloader.get(@source)
    parsed_info = Parser::Rss.new.parse(source)

    channel = parsed_info[:info]
    assert channel[:description] == 'Практические уроки по программированию'
    assert channel[:link] == 'https://ru.hexlet.io/'

    assert parsed_info[:items].size == 2
  end
end
