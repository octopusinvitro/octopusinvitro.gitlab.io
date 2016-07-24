# frozen_string_literal: true

require_relative '../presenters/pseudo_article_gh_repos'
require_relative '../presenters/pseudo_article_gh_search'
require_relative '../presenters/pseudo_article_gl_repos'

def max
  7
end

def strip_tags(html)
  Nokogiri::HTML(html).text
end

def deprecation_notice
  age = Date.today.year - current_article.date.year
  message = '<div class="deprecation">' \
      "<strong>Caution!</strong> This article is #{age} years old. " \
      'It may be obsolete or show old techniques. It may also still be relevant, and you may find it useful! ' \
      'So it has been marked as <strong>deprecated</strong>, just in case. ' \
      '</div>'

  message if age > 2
end

def reading_time(input)
  words_per_minute = 100
  minutes  = (input.split.size / words_per_minute).floor
  svgclock = '<svg aria-hidden="true" class="icon-clock">' \
             '<use href="/images/symbol-defs.svg#icon-clock"></use>' \
             '</svg>'
  "#{svgclock} #{minutes} min. read"
end

def retweet_url(current_page)
  url = current_url(current_page)
  "https://twitter.com/intent/tweet?url=#{url}&amp;text=#{current_page.title}&amp;via=#{username}"
end

def current_url(current_page)
  siteurl + current_page.url
end

def github_search_list(languages, github_user)
  languages.map do |language|
    PseudoArticleGHSearch.new(language:, github_user:)
  end
end

def github_repos_list(repo_urls, github_user)
  repo_urls.map do |repo_url|
    PseudoArticleGHRepos.new(repo_url:, github_user:)
  end
end

def gitlab_repos_list(repo_names, github_user)
  repo_names.map do |repo_name|
    PseudoArticleGLRepos.new(repo_name:, github_user:)
  end
end
