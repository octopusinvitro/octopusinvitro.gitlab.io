# frozen_string_literal: true

require_relative '../../helpers/articles'

RSpec.describe 'Articles helper' do
  # describe '#tags_sorted' do
  #   it 'sorts tags from more articles to less' do
  #     expect(middleman_app.send(:tags_sorted, 4)).to eq('foo')
  #   end
  #
  #   it 'gets only blog articles' do
  #     expect(middleman_app.send(:tags_sorted, 4)).to_not include('foo')
  #   end
  #
  #   it 'does not return "featured" tag' do
  #     expect(middleman_app.send(:tags_sorted, 4)).to_not include('featured')
  #   end
  # end

  describe '#featured_image' do
    it 'returns custom if present in frontmatter' do
      id = 'posts/test/2022-02-23-article-with-featured-image'
      host = middleman_app.send(:image_host)
      expect(middleman_app.send(:featured_image, article(id))).to eq("#{host}/path-to-image.png")
    end

    it 'returns default if not present in frontmatter' do
      id = 'posts/test/2022-02-22-article'
      expect(middleman_app.send(:featured_image, article(id))).to_not be_empty
    end
  end

  describe '#featured_image_alt' do
    it 'returns custom if present in frontmatter' do
      id = 'posts/test/2022-02-23-article-with-featured-image'
      expect(middleman_app.send(:featured_image_alt, article(id))).to eq('Alt text')
    end

    it 'returns nothing if not present in frontmatter' do
      id = 'posts/test/2022-02-22-article'
      expect(middleman_app.send(:featured_image_alt, article(id))).to be_empty
    end
  end

  describe '#article_tags' do
    it 'returns all tags except "featured"' do
      id = 'posts/test/2022-02-02-featured'
      expect(middleman_app.send(:article_tags, article(id))).to eq(['dog'])
    end
  end

  def article(id)
    middleman_app.sitemap.resources.find { |resource| resource.page_id == id }
  end
end
