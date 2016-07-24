# frozen_string_literal: true

require 'middleman'
require 'middleman-blog'
require 'middleman-livereload'
require 'pry'

def middleman_app # rubocop:disable Metrics/MethodLength
  ENV['MM_ROOT'] = File.expand_path('fixtures/test-app', __dir__)

  Middleman::Application.new do
    configure(:development) { set :helpers_dir, File.expand_path('../helpers', __dir__) }

    activate :blog do |blog|
      blog.name = 'work'
      blog.sources = 'work/{category}{year}-{month}-{day}-{title}.html'
    end

    activate :blog do |blog|
      blog.name = 'blog'
      blog.sources = 'posts/{category}{year}-{month}-{day}-{title}.html'
    end
  end
end

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
  config.order = :random
  config.warnings = false
  # config.profile_examples = 10
  # config.default_formatter = 'doc' if config.files_to_run.one?
  # Kernel.srand config.seed
end
