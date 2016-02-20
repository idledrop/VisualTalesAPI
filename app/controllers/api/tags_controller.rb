class Api::TagsController < ApiController

  def index
    tags = Tag.all
    render json: tags
  end

end