# frozen_string_literal: true

def tags_sorted(number_of_tags)
  blog_tags
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

def work_tag(tag)
  select_by_tag(work_articles, tag)
end

def blog_tags
  get_tags(blog('blog'))
end

def work_tags
  get_tags(blog('work'))
end

def featured_image(article)
  article.data[:featured_image] || '/images/default-image.png'
end

def featured_image_alt(article)
  article.data[:featured_image_alt] || ''
end

def article_tags(article)
  article.tags.reject { |tag| tag == 'featured' }
end

private

def select_by_tag(article_list, tag)
  article_list.select do |article|
    tags = article.data[:tags]
    tags.include?(tag) if tags
  end
end

def get_tags(selected_blog)
  selected_blog.tags.reject { |tag, _articles| tag == 'featured' }
end
