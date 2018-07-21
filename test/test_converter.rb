# frozen_string_literal: true

require_relative 'test_helper'

class TestConverter < Minitest::Test
  def setup
    @options = {
      source: 'test/fixtures/test_feed.xml'
    }

    @downloader = Downloader::Filesystem.new
  end

  def test_file
    source = @options[:source]
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

  def test_stdin
    source = nil
    fylesystem = Downloader::Filesystem
    network = Downloader::Http
    stdin = Downloader::Stdin

    assert !fylesystem.usable?(source)
    assert !network.usable?(source)
    assert stdin.usable?(source)
  end

  def test_parsing
    source = @downloader.download(@options[:source])
    parsed_info = Parser::Atom.new.parse(source)

    channel = parsed_info[:info]
    assert channel[:description] == 'Практические уроки по программированию'
    assert channel[:link] == 'https://ru.hexlet.io/'

    assert parsed_info[:items].size == 2
  end
end
