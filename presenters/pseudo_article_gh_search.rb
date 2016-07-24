# frozen_string_literal: true

class PseudoArticleGHSearch
  def initialize(language:, github_user:)
    @language = language
    @github_user = github_user
  end

  def url
    "https://github.com/search?l=#{language}" \
    "&q=user:#{github_user}+&s=updated&type=Repositories"
  end

  def data
    {
      featured_image: "/images/language-logos/#{language.downcase}.png",
      featured_image_alt: "#{language} repos by #{github_user}"
    }
  end

  def title
    language
  end

  private

  attr_reader :language, :github_user
end
