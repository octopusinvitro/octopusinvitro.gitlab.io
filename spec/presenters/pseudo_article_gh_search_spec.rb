# frozen_string_literal: true

require_relative '../../presenters/pseudo_article_gh_search'

RSpec.describe PseudoArticleGHSearch do
  let(:presenter) { described_class.new(language: 'Ruby', github_user: 'octopus') }

  describe '#url' do
    it 'includes the language' do
      expect(presenter.url).to include('Ruby')
    end

    it 'includes the user' do
      expect(presenter.url).to include('Ruby')
    end
  end

  describe '#data' do
    it 'contains language logo path downcasing language name' do
      expect(presenter.data[:featured_image]).to include('ruby')
    end

    it 'contains alt text including language' do
      expect(presenter.data[:featured_image_alt]).to include('Ruby')
    end

    it 'contains alt text including user' do
      expect(presenter.data[:featured_image_alt]).to include('octopus')
    end
  end

  describe '#title' do
    it 'is the language name' do
      expect(presenter.title).to eq('Ruby')
    end
  end
end
