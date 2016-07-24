# frozen_string_literal: true

Time.zone = 'London'
###
# Page options, layouts, aliases and proxies
###

# Per-page layout changes:
#
# With no layout
page '/*.xml',    layout: false
page '/*.json',   layout: false
page '/*.txt',    layout: false
page '/feed.xml', layout: false

# With alternative layout
# page '/blog.html', layout: 'blog'

# A path which all have the same layout
# with_layout :admin do
#   page '/admin/*'
# end

# Proxy pages (https://middlemanapp.com/advanced/dynamic_pages/)
# proxy '/this-page-has-no-template.html', '/template-file.html', :locals => {
#  :which_fake_page => 'Rendering a fake page with a local variable' }

###
# Helpers
###

# Automatic image dimensions on image_tag helper
# activate :automatic_image_sizes

# Methods defined in the helpers block are available in templates
# helpers do
#   def some_helper
#     'Helping'
#   end
# end

set :css_dir,     'stylesheets'
set :js_dir,      'javascripts'
set :images_dir,  'images'

configure :build do
  set :build_dir, 'public'
  # set :base_url, '/middleman' # baseurl for GitLab Pages (project name)
  #  - leave empty if you're building a user/group website

  activate :minify_css
  activate :minify_javascript
  activate :gzip

  # Pretty URLs
  activate :directory_indexes

  # Use relative URLs
  # activate :relative_assets

  # Enable cache buster
  # activate :asset_hash

  # Or use a different image path
  # set :http_prefix, '/Content/images/'
end

configure :development do
  set :relative_links, true
  activate :livereload
  # livereload_css_target: 'stylesheets/styles.css'
  activate :directory_indexes
  # activate :relative_assets
  # activate :asset_hash
end

activate :blog do |blog|
  blog.name = 'work'

  # Matcher for blog source files
  blog.sources = 'work/{category}/{year}-{month}-{day}-{title}.html'

  blog.permalink  = 'work/{category}/{title}'
  blog.year_link  = 'work/{year}.html'
  blog.month_link = 'work/{year}/{month}.html'
  blog.day_link   = 'work/{year}/{month}/{day}.html'
  blog.taglink    = 'work/tags/{tag}.html'
  blog.custom_collections = {
    category: {
      link: '/work/{category}.html',
      template: '/category_w.html'
    }
  }

  blog.layout = 'work'
  blog.tag_template = 'tag_w.html'
  blog.calendar_template = 'calendar.html'
end

activate :blog do |blog|
  # This will add a prefix to all links, template references and source paths
  # blog.prefix = 'blog'

  blog.name = 'blog'

  # Matcher for blog source files
  blog.sources = 'posts/{category}/{year}-{month}-{day}-{title}.html'

  blog.permalink  = 'blog/{category}/{title}'
  blog.year_link  = 'blog/{year}.html'
  blog.month_link = 'blog/{year}/{month}.html'
  blog.day_link   = 'blog/{year}/{month}/{day}.html'
  blog.taglink    = 'blog/tags/{tag}.html'
  blog.custom_collections = {
    category: {
      link: '/blog/{category}.html',
      template: '/category.html'
    }
  }

  blog.layout = 'post'
  blog.tag_template = 'tag.html'
  blog.calendar_template = 'calendar.html'

  # blog.summary_separator = /(READMORE)/
  # blog.summary_length = 250
  # blog.default_extension = '.markdown'

  # Enable pagination
  # blog.paginate = true
  # blog.per_page = 10
  # blog.page_link = 'page/{num}'
end
