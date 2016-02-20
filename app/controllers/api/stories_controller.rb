class Api::StoriesController < ApiController

  def index
    stories = Story.all
    render json: stories
  end
end