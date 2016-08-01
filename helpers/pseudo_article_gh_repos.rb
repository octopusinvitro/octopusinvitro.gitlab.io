# frozen_string_literal: true

class PseudoArticleGHRepos
  def initialize(repo_url:, github_user:)
    @repo_url = repo_url
    @github_user = github_user
  end

  def url
    repo_url
  end

  def data
    {
      featured_image: '/images/django-pony.png',
      featured_image_alt: "#{repo_url} repo by #{github_user}"
    }
  end

  def title
    repo_url.split('/').last.split('-').join('-<br>')
  end

  private

  attr_reader :repo_url, :github_user
end
