# frozen_string_literal: true

require_relative '../../presenters/anchorizer'

RSpec.describe Anchorizer do
  describe '#anchorize' do
    it 'anchorizes headings' do
      anchorized = described_class.new('<h2>hello</h2>').anchorize
      expect(anchorized).to include('<h2 id="hello">hello<a href="#hello" class="anchor">')
    end

    it 'lowcases heading text' do
      anchorized = described_class.new('<h2>Hello</h2>').anchorize
      expect(anchorized).to include('<h2 id="hello">Hello<a href="#hello" class="anchor">')
    end

    it 'dashifies any number of spaces' do
      anchorized = described_class.new('<h3>hello   world</h3>').anchorize
      expect(anchorized).to include('<h3 id="hello-world">hello   world<a href="#hello-world" class="anchor">')
    end

    it 'dashifies quotes' do
      anchorized = described_class.new(%q(<h4>Cat's "luck"</h4>)).anchorize
      expect(anchorized).to include(%q(<h4 id="cat-s--luck">Cat's "luck"<a href="#cat-s--luck" class="anchor">))
    end

    it 'dashifies special characters' do
      anchorized = described_class.new('<h4>hi.*/-\)$+(^?!~`hi</h4>').anchorize
      expect(anchorized).to include('<h4 id="hi--------------hi">')
    end

    it 'strips dashes at start and end' do
      anchorized = described_class.new('<h4>-hello-</h4>').anchorize
      expect(anchorized).to include('<h4 id="hello">-hello-<a href="#hello" class="anchor">')
    end

    it 'does nothing if no headings present' do
      no_headings = '<p>hello</p>'
      anchorized = described_class.new(no_headings).anchorize
      expect(anchorized).to eq(no_headings)
    end

    it 'does nothing if main heading' do
      main_heading = '<h1>hello</h1>'
      anchorized = described_class.new(main_heading).anchorize
      expect(anchorized).to include(main_heading)
    end
  end
end
