# frozen_string_literal: true

require 'nokogiri'

class Anchorizer
  HASH = '#'
  DASH = '-'
  ANCHOR = '<svg aria-hidden="true" class="icon-anchor">' \
           '<use href="/images/symbol-defs.svg#icon-anchor"></use>' \
           '</svg>'

  attr_reader :body

  def initialize(body)
    @body = Nokogiri::HTML(body)
  end

  def anchorize
    add_anchors
    body.at('body').children.to_html(indent: 2)
  end

  private

  def add_anchors
    headings.each do |heading|
      anchor = dashify(heading.text.downcase)
      a_tag = a_tag(anchor)

      heading['id'] = anchor

      heading.add_next_sibling(a_tag)
      a_tag.parent = heading
    end
  end

  def headings
    body.css('h2, h3, h4')
  end

  def a_tag(anchor)
    a_tag = Nokogiri::XML::Node.new('a', body)
    a_tag.inner_html = ANCHOR
    a_tag['href'] = "#{HASH}#{anchor}"
    a_tag['class'] = 'anchor'
    a_tag
  end

  def dashify(text)
    special_characters = %r{(\s+|'|"|\.|\*|/|-|\\|\)|\$|\+|\(|\^|\?|!|~|`)}
    strip_start_and_end_dash(text.gsub(special_characters, DASH))
  end

  def strip_start_and_end_dash(text)
    text = text[1..] while text[0] == DASH
    text = text[0...-1] while text[-1] == DASH

    text
  end
end
