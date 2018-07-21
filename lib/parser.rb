# frozen_string_literal: true

require_relative 'parser/rss'
require_relative 'parser/atom'

module Parser
  def self.parse(source)
    Parser::Atom.parse(source)
  end
end
