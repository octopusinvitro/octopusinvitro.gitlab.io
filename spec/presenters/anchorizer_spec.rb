# frozen_string_literal: true

require_relative '../../presenters/anchorizer'

RSpec.describe Anchorizer do
  describe '#anchorize' do
    it 'does nothing if no headings present' do
      anchorized = described_class.new('<p>hello</p>').anchorize
      expected = '<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" ' \
                 '"http://www.w3.org/TR/REC-html40/loose.dtd">' \
                 "\n<html><body><p>hello</p></body></html>\n"
      expect(anchorized).to eq(expected)
    end

    it 'does nothing if main heading' do
      main_heading = '<h1>hello</h1>'
      anchorized = described_class.new(main_heading).anchorize
      expect(anchorized).to include(main_heading)
    end

    it 'anchorizes headings' do
      anchorized = described_class.new('<h2>hello</h2>').anchorize
      expect(anchorized).to include('<h2 id="hello">hello<a href="#hello" class="anchor">#</a>')
    end

    it 'dashifies any number of spaces' do
      anchorized = described_class.new('<h3>hello   world</h3>').anchorize
      expect(anchorized).to include('<h3 id="hello-world">hello   world<a href="#hello-world" class="anchor">#</a>')
    end

    it 'dashifies quotes' do
      anchorized = described_class.new(%q(<h4>Cat's "luck"</h4>)).anchorize
      expect(anchorized).to include(%q(<h4 id="Cat-s--luck">Cat's "luck"<a href="#Cat-s--luck" class="anchor">#</a>))
    end

    it 'dashifies special characters' do
      anchorized = described_class.new('<h4>hi.*/-\)$+(^?!~`hi</h4>').anchorize
      expect(anchorized).to include('<h4 id="hi--------------hi">')
    end

    it 'strips dashes at start and end' do
      anchorized = described_class.new('<h4>-hello-</h4>').anchorize
      expect(anchorized).to include('<h4 id="hello">-hello-<a href="#hello" class="anchor">#</a>')
    end
  end
end
