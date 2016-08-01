# frozen_string_literal: true

require 'nokogiri'

module AnchorHelpers
  def anchorize(input)
    HeadingAnchor.new(input).anchorize
  end

  class HeadingAnchor
    attr_reader :body

    def initialize(body)
      @body = Nokogiri::HTML(body)
    end

    def anchorize
      add_anchors
      body.to_html(indent: 2)
    end

    private

    CLASS   = 'anchor'
    CONTENT = '#'
    SEP     = '-'

    def add_anchors
      headings.each do |hx|
        link          = Nokogiri::XML::Node.new 'a', body
        link.content  = CONTENT
        link['class'] = CLASS

        anchor       = dashify(hx.text)
        link['href'] = "#{CONTENT}#{anchor}"
        hx['id']     = anchor

        hx.add_next_sibling(link)
        link.parent = hx
      end
    end

    def headings
      body.css('h2, h3')
      # body.at_css('h2')
    end

    def dashify(text)
      dashify_special_characters(text).split.join(SEP)
    end

    def dashify_special_characters(text)
      specialcharacter = %r{/(\'|\"|\.|\*|\/|\-|\\|\)|\$|\+|\(|\^|\?|\!|\~|\`)/}
      strip(text.gsub(specialcharacter) { |_match| SEP })
    end

    def strip(text)
      strip_end(strip_start(text))
    end

    def strip_start(text)
      text[1..-1] while text[0] == SEP
      text
    end

    def strip_end(text)
      text[0...-1] while text[-1] == SEP
      text
    end
  end
end
