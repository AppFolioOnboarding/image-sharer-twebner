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
    tag_list = "tag1, tag2"
    image = Image.new(url: url, tag_list: tag_list)
    assert image.save

    get image_url(image.id)

    assert_response :success
    assert_select "img:match('src', ?)", url
    assert_select "p", tag_list
  end

  def test_create_valid
    url = 'https://i.natgeofe.com/k/66d3a80c-f4c3-4410-845c-3543375eaa85/cheetah-watching.jpg'
    tag_list = "tag1, tag2, tag3"
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
    Image.create(url: 'https://i.natgeofe.com/k/66d3a80c-f4c3-4410-845c-3543375eaa85/cheetah-watching.jpg', tag_list: "cheetah")
    Image.create(url: 'https://images.theconversation.com/files/285143/original/file-20190722-11355-1peled7.jpg', tag_list: "zebra, tag2")
    Image.create(url: 'https://www.apa.org/images/2020-03-feature-giraffe_tcm7-269465.png', tag_list: "")

    get images_url

    assert_response :success
    assert_select 'a', 'New image'

    assert_select 'img', count: 3 do |images|
      assert_equal Image.last.url, images[0].attributes['src'].value
      assert_equal Image.second_to_last.url, images[1].attributes['src'].value
      assert_equal Image.third_to_last.url, images[2].attributes['src'].value
    end

    assert_select 'p', count: 3 do |tags|
      assert_equal Image.last.tag_list.join(', '), tags[0].text
      assert_equal Image.second_to_last.tag_list.join(', '), tags[1].text
      assert_equal Image.third_to_last.tag_list.join(', '), tags[2].text
    end
  end
end
