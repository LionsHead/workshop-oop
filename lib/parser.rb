# frozen_string_literal: true

require_relative 'parser/rss'
require_relative 'parser/atom'

class Parser
  def parse(source)
    Parser::Atom.new.parse(source)
  end
end
