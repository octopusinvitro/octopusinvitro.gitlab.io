# frozen_string_literal: true

require_relative '../../presenters/pseudo_article_gl_repos'

RSpec.describe PseudoArticleGLRepos do
  let(:presenter) { described_class.new(repo_name: 'repo-name', github_user: 'octopus') }

  describe '#url' do
    it 'includes the user' do
      expect(presenter.url).to include('octopus')
    end

    it 'includes the repo name' do
      expect(presenter.url).to include('repo-name')
    end
  end

  describe '#data' do
    it 'contains repo logo path' do
      expect(presenter.data[:featured_image]).to_not be_nil
    end

    it 'contains alt text including repo name' do
      expect(presenter.data[:featured_image_alt]).to include('repo-name')
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
