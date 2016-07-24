# frozen_string_literal: true

class TaxonomyItem
  attr_reader :path, :legend

  def initialize(path, legend)
    @path = path
    @legend = legend
  end
end
