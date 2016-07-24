# frozen_string_literal: true

def tags_sorted(number_of_tags)
  get_tags(blog('blog'))
    .sort_by { |_tag, articles| articles.size }
    .reverse[0...number_of_tags]
end

def blog_articles
  blog('blog').articles
end

def work_articles
  blog('work').articles
end

def featured_posts
  select_by_tag(blog_articles, 'featured')
end

def featured_work
  select_by_tag(work_articles, 'featured')
end

def work_category(category)
  work_articles.select { |article| article.data[:category] == category }
end

def non_game_projects
  work_category('projects').reject { |article| article.tags.include?('games') }
end

def work_tag(tag)
  select_by_tag(work_articles, tag)
end

def blog_tags
  get_tags(blog('blog')).sort_by { |tag, _articles| tag.downcase }
end

def work_tags
  get_tags(blog('work')).sort_by { |tag, _articles| tag.downcase }
end

def image_host
  'https://ik.imagekit.io/octopusinvitro'
end

def featured_image(article)
  image_host + (article.data[:featured_image] || '/images/default-image.png')
end

def featured_image_alt(article)
  article.data[:featured_image_alt] || ''
end

def article_tags(article = current_article)
  article.tags.reject { |tag| tag == 'featured' }
end

def illustration?
  current_article.data.categories.include?('Illustration')
end

private

def select_by_tag(article_list, tag)
  article_list.select do |article|
    tags = article.data[:tags]
    tags&.include?(tag)
  end
end

def get_tags(selected_blog)
  selected_blog.tags.reject { |tag, _articles| tag == 'featured' }
end
