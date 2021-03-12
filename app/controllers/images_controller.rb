class ImagesController < ActionController::Base
  protect_from_forgery with: :exception

  def new
    @image = Image.new
  end

  def show
    @image = Image.find(params[:id])
  end

  def create
    @image = Image.new(image_params)

    if @image.save
      redirect_to @image
    else
      render :new, status: :unprocessable_entity
    end
  end

  def index
    @images = if params.key? :tag
                Image.tagged_with(params[:tag])
              else
                Image.order(id: :desc)
              end
  end

  private

  def image_params
    params.require(:image).permit(:url, :tag_list)
  end
end
