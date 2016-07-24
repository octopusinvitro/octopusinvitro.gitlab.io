# frozen_string_literal: true

require_relative '../../presenters/pseudo_article_gh_repos'

RSpec.describe PseudoArticleGHRepos do
  let(:repo_url) { 'http://home/repo-name' }
  let(:presenter) { described_class.new(repo_url:, github_user: 'octopus') }

  describe '#url' do
    it 'returns repo URL with no transformations' do
      expect(presenter.url).to include(repo_url)
    end
  end

  describe '#data' do
    it 'contains repo logo path' do
      expect(presenter.data[:featured_image]).to_not be_nil
    end

    it 'contains alt text including repo URL' do
      expect(presenter.data[:featured_image_alt]).to include(repo_url)
    end

    it 'contains alt text including user' do
      expect(presenter.data[:featured_image_alt]).to include('octopus')
    end
  end

  describe '#title' do
    it 'is the repo name inserting newlines after dashes' do
      expect(presenter.title).to eq('repo-<br>name')
    end
  end
end
