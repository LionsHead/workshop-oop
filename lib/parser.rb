# frozen_string_literal: true

require 'require_all'
require_rel 'parser'

class Parser
  def parse(source)
    Parser::Atom.new.parse(source)
  end
end
