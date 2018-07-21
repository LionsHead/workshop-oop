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

  def test_file
    downloader = Downloader::Filesystem.new(@options[:source])
    assert downloader.usable?
  end

  def test_http
    downloader = Downloader::Http.new('https://ru.hexlet.io/lessons.rss')
    assert downloader.usable?
  end

  def test_stdin
    downloader = Downloader::Stdin.new(@options[:source])
    assert downloader.usable?
  end

  def test_parsing
    source = Downloader::Http.new(@options[:source]).download
    parsed_info = Parser::Atom.new.parse(source)
    channel = parsed_info[:info]

    assert channel[:description] == 'Практические уроки по программированию'
    assert channel[:link] == 'https://ru.hexlet.io/'
  end
end
