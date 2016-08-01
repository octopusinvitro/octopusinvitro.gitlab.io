# frozen_string_literal: true

class PseudoArticleGLRepos
  def initialize(repo_name:, github_user:)
    @repo_name = repo_name
    @github_user = github_user
  end

  def url
    "https://gitlab.com/octopusinvitro/#{repo_name}"
  end

  def data
    {
      featured_image: '/images/ruby-on-rails.png',
      featured_image_alt: "#{repo_name} repo by #{github_user}"
    }
  end

  def title
    repo_name.split('-').join('-<br>')
  end

  private

  attr_reader :repo_name, :github_user
end
