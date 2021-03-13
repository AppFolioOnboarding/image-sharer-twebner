require 'test_helper'

class ImageTest < ActiveSupport::TestCase
  def test_no_url
    image = Image.new
    assert_not image.save
  end

  def test_url_missing_http
    image = Image.new(url: 'abc.jpeg')
    assert_not image.save
  end

  def test_url_missing_image_ext
    image = Image.new(url: 'https')
    assert_not image.save
  end

  def test_valid_url
    image = Image.new(url: 'https://i.natgeofe.com/k/66d3a80c-f4c3-4410-845c-3543375eaa85/cheetah-watching.jpg')
    assert image.save
  end

  def test_valid_url_with_tags
    image = Image.new(url: 'https://i.natgeofe.com/k/66d3a80c-f4c3-4410-845c-3543375eaa85/cheetah-watching.jpg',
                      tag_list: %w[tag1 tag2 tag3])
    assert image.save
  end
end
