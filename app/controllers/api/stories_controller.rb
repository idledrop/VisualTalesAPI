class Api::StoriesController < ApiController

  def index
    stories = Story.all
    render json: stories
  end

  def create
  	@story = Story.new(params.permit(Story.column_names))
  	@story.save!
  	render json: @story.to_json
  end

end