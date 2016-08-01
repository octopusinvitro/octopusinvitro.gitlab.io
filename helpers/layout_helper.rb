# frozen_string_literal: true

def siteurl
  'http://octopusinvitro.tk/'
end

def author_name
  'Octopus in Vitro'
end

def author_twitter
  '@octopusinvitro'
end

def username
  'octopusinvitro'
end

def blog?
  page_classes.include? 'blog'
end

def work?
  page_classes.include? 'work'
end

def current_page_title
  if article_title?
    current_article.title
  elsif page_title?
    current_page.data.title
  else
    author_name
  end
end

private

def article_title?
  !(current_article.nil? || current_article.title.empty?)
end

def page_title?
  !(current_page.data.title.nil? || current_page.data.title.empty?)
end
