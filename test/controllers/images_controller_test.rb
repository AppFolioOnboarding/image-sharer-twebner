require 'test_helper'

class ImagesControllerTest < ActionDispatch::IntegrationTest
  def test_new_success
    get new_image_url

    assert_response :success
    assert_select 'form.js-image-form'
  end

  def test_show_success
    url = 'https://i.natgeofe.com/k/66d3a80c-f4c3-4410-845c-3543375eaa85/cheetah-watching.jpg'
    image = Image.new(url: url)
    assert image.save

    get image_url(image.id)

    assert_response :success
    assert_select "img:match('src', ?)", url
  end

  def test_create_valid
    url = 'https://i.natgeofe.com/k/66d3a80c-f4c3-4410-845c-3543375eaa85/cheetah-watching.jpg'
    assert_difference('Image.count', 1) do
      post images_url, params: { image: { url: url } }
    end

    assert_equal url, Image.last.url
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
    url1 = 'https://i.natgeofe.com/k/66d3a80c-f4c3-4410-845c-3543375eaa85/cheetah-watching.jpg'
    Image.create(url: url1)
    url2 = 'https://images.theconversation.com/files/285143/original/file-20190722-11355-1peled7.jpg'
    Image.create(url: url2)
    url3 = 'https://www.apa.org/images/2020-03-feature-giraffe_tcm7-269465.png'
    Image.create(url: url3)

    get images_url
    assert_response :success
    assert_select 'img' do |images|
      assert_equal Image.last.url, images[0].attributes['src'].value
      assert_equal Image.second_to_last.url, images[1].attributes['src'].value
      assert_equal Image.third_to_last.url, images[2].attributes['src'].value
    end
    assert_select 'a', 'New image'
  end
end
