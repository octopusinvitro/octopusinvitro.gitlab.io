# frozen_string_literal: true

require_relative '../../helpers/custom'

RSpec.describe 'Custom helper' do
  describe '#strip_tags' do
    it 'extracts text from markdown' do
      markdown = '<html> hello world </html>'
      text = ' hello world '
      expect(middleman_app.send(:strip_tags, markdown)).to eq(text)
    end
  end

  describe '#reading_time' do
    it 'calculates it in minutes' do
      input = 'hello ' * 101
      markdown = middleman_app.send(:reading_time, input)

      expect(markdown).to include('1 min.')
    end

    it 'includes icon' do
      input = 'hello ' * 201
      markdown = middleman_app.send(:reading_time, input)

      expect(markdown).to include('</svg> 2 min.')
    end
  end

  describe '#github_search_list' do
    it 'returns list of search presenters' do
      list = middleman_app.send(:github_search_list, %w[Ruby Python], 'octopus')
      expect(list.map(&:title)).to eq(%w[Ruby Python])
    end
  end

  describe '#github_repos_list' do
    it 'returns list of Github repo presenters' do
      list = middleman_app.send(:github_repos_list, %w[http://repo1 http://repo2], 'octopus')
      expect(list.map(&:title)).to eq(%w[repo1 repo2])
    end
  end

  describe '#gitlab_repos_list' do
    it 'returns list of Gitlab repo presenters' do
      list = middleman_app.send(:gitlab_repos_list, %w[repo1 repo2], 'octopus')
      expect(list.map(&:title)).to eq(%w[repo1 repo2])
    end
  end
end
