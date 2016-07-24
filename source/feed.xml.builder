---
blog: blog # rubocop:disable Lint/Syntax
---

xml.instruct!

xml.feed('xmlns' => 'http://www.w3.org/2005/Atom') do
  xml.title(author_name)
  xml.subtitle('Polyglot developer')

  xml.id(URI.join(siteurl, blog.options.prefix.to_s))
  xml.link('href' => URI.join(siteurl, blog.options.prefix.to_s))
  xml.link('href' => URI.join(siteurl, current_page.path), 'rel' => 'self')

  xml.updated(blog.articles.first.date.to_time.iso8601) unless blog.articles.empty?
  xml.author { xml.name(author_name) }

  blog('blog').articles[0..5].each do |article|
    xml.entry { entry(xml, article) }
  end

  blog('work').articles[0..5].each do |article|
    xml.entry { entry(xml, article) }
  end
end
