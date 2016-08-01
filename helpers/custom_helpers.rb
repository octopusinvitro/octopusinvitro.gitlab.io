# frozen_string_literal: true

MAX = 7

def strip_tags(html)
  html.gsub(%r{/<\/?[^>]*>/}, '') if html
end

def reading_time(input)
  words_per_minute = 100
  minutes  = (input.split.size / words_per_minute).floor
  svgclock = '<svg aria-hidden="true" class="icon-clock">' \
             '<use xlink:href="/images/symbol-defs.svg#icon-clock"></use>' \
             '</svg>'
  "#{svgclock} #{minutes} min. read"
end

def github_search_list(languages, github_user)
  languages.map do |language|
    PseudoArticleGHSearch.new(language: language, github_user: github_user)
  end
end

def github_repos_list(repo_urls, github_user)
  repo_urls.map do |repo_url|
    PseudoArticleGHRepos.new(repo_url: repo_url, github_user: github_user)
  end
end

def gitlab_repos_list(repo_names, github_user)
  repo_names.map do |repo_name|
    PseudoArticleGLRepos.new(repo_name: repo_name, github_user: github_user)
  end
end
