# frozen_string_literal: true

require_relative '../presenters/anchorizer'

def anchorize(input)
  Anchorizer.new(input).anchorize
end
