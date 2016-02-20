class Api::TagsController < ApiController

  def index
    tags = Tag.all
    render json: tags
  end

  def search
    tags = Tag.where("name LIKE :query", query: "%#{params[:query]}%")
    render json: tags
  end

end