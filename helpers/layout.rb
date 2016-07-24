# frozen_string_literal: true

require_relative '../presenters/taxonomy_item'

def siteurl
  'https://octopusinvitro.gitlab.io'
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

def twitter_url
  'https://twitter.com/octopusinvitro'
end

def about?
  page_classes.include? 'about'
end

def blog?
  page_classes.include? 'blog'
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

def blog_taxonomy
  taxonomy_items(
    ['/blog/code-and-tech', 'Code &amp; tech'],
    ['/blog/machine-learning', 'Machine L.'],
    ['/blog/web-development', 'Web Dev.'],
    ['/blog/thoughts', 'Thoughts']
  )
end

def work_taxonomy
  taxonomy_items(
    ['/work/projects', 'Projects'],
    ['/work/machine-learning', 'Machine L.'],
    ['/work/web-dev', 'Web Dev.'],
    ['/work/illustration', 'Illustration']
  )
end

def entry(xml, article) # rubocop:disable Metrics/AbcSize
  xml.title(article.title)
  xml.link('rel' => 'alternate', 'href' => URI.join(siteurl, article.url))
  xml.id(URI.join(siteurl, article.url))
  xml.published(article.date.to_time.iso8601)
  xml.updated(File.mtime(article.source_file).iso8601)
  xml.author { xml.name(author_name) }
  xml.summary(strip_tags(article.summary), 'type' => 'html')
  xml.content(article.body, 'type' => 'html')
end

private

def article_title?
  !(current_article.nil? || current_article.title.empty?)
end

def page_title?
  !(current_page.data.title.nil? || current_page.data.title.empty?)
end

def taxonomy_items(*items)
  items.map { |path, legend| TaxonomyItem.new(path, legend) }
end
