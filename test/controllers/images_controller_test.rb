require 'test_helper'

class ImagesControllerTest < ActionDispatch::IntegrationTest
  def test_new_success
    get new_image_url

    assert_response :success
    assert_select 'form.js-image-form'
    assert_select 'input#image_url', 1
    assert_select 'input#image_tag_list', 1
  end

  def test_show_success
    url = 'https://i.natgeofe.com/k/66d3a80c-f4c3-4410-845c-3543375eaa85/cheetah-watching.jpg'
    tags = %w[tag1 tag2]
    image = Image.new(url: url, tag_list: tags.join(', '))
    assert image.save

    get image_url(image.id)

    assert_response :success
    assert_select "img:match('src', ?)", url

    assert_select 'a', count: 2 do |tag_links|
      assert_equal tags[0], tag_links[0].text
      assert_equal images_path(tag: tags[0]), tag_links[0]['href']

      assert_equal tags[1], tag_links[1].text
      assert_equal images_path(tag: tags[1]), tag_links[1]['href']
    end
  end

  def test_create_valid
    url = 'https://i.natgeofe.com/k/66d3a80c-f4c3-4410-845c-3543375eaa85/cheetah-watching.jpg'
    tag_list = 'tag1, tag2, tag3'
    assert_difference('Image.count', 1) do
      post images_url, params: { image: { url: url, tag_list: tag_list } }
    end

    assert_equal url, Image.last.url
    assert_equal tag_list.split(', '), Image.last.tag_list
    assert_redirected_to image_path(Image.last)
  end

  def test_create_invalid
    assert_no_difference 'Image.count' do
      post images_url, params: { image: { url: '' } }
    end

    assert_response :unprocessable_entity
    assert_select 'form.js-image-form'
    assert_select '.invalid-feedback'
  end

  def test_index_success
    Image.create(url: 'https://i.natgeofe.com/k/66d3a80c-f4c3-4410-845c-3543375eaa85/cheetah-watching.jpg',
                 tag_list: 'cheetah')
    Image.create(url: 'https://images.theconversation.com/files/285143/original/file-20190722-11355-1peled7.jpg',
                 tag_list: 'zebra, tag2')
    Image.create(url: 'https://www.apa.org/images/2020-03-feature-giraffe_tcm7-269465.png', tag_list: '')

    get images_url

    assert_response :success
    assert_select 'a', 'New image'

    assert_select 'img', count: 3 do |images|
      assert_equal Image.last.url, images[0].attributes['src'].value
      assert_equal Image.second_to_last.url, images[1].attributes['src'].value
      assert_equal Image.third_to_last.url, images[2].attributes['src'].value
    end

    assert_select 'a.js-image-tag', count: 3 do |tag_links|
      assert_equal 'zebra', tag_links[0].text
      assert_equal images_path(tag: 'zebra'), tag_links[0]['href']

      assert_equal 'tag2', tag_links[1].text
      assert_equal images_path(tag: 'tag2'), tag_links[1]['href']

      assert_equal 'cheetah', tag_links[2].text
      assert_equal images_path(tag: 'cheetah'), tag_links[2]['href']
    end
  end

  def test_index_by_tag
    Image.create(url: 'https://i.natgeofe.com/k/66d3a80c-f4c3-4410-845c-3543375eaa85/cheetah-watching.jpg',
                 tag_list: 'cheetah')
    Image.create(url: 'https://images.theconversation.com/files/285143/original/file-20190722-11355-1peled7.jpg',
                 tag_list: 'zebra, tag2')
    Image.create(url: 'https://www.apa.org/images/2020-03-feature-giraffe_tcm7-269465.png', tag_list: 'tag2')

    get images_url(tag: 'tag2')

    assert_response :success

    assert_select 'img', count: 2 do |images|
      assert_equal Image.last.url, images[1].attributes['src'].value
      assert_equal Image.second_to_last.url, images[0].attributes['src'].value
    end

    assert_select 'a.js-image-tag', count: 3 do |tag_links|
      assert_equal 'zebra', tag_links[0].text
      assert_equal images_path(tag: 'zebra'), tag_links[0]['href']

      assert_equal 'tag2', tag_links[1].text
      assert_equal images_path(tag: 'tag2'), tag_links[1]['href']

      assert_equal 'tag2', tag_links[2].text
      assert_equal images_path(tag: 'tag2'), tag_links[2]['href']
    end
  end
end
