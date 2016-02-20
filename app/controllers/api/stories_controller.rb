class Api::StoriesController < ApiController

  def index
    stories = Story.all
    render json: stories
  end

  def search
  	stories = Story
  	if params[:title].present?
  		stories = stories.where("title LIKE :query", query: "%#{params[:title]}%")
  	end
  	if params[:tag_ids].present?
  		stories = stories.joins(:story_tags).where("story_tags.tag_id in (:tag_ids)", tag_ids: params[:tag_ids].split(','))
  	end
	  render json: stories
  end

  def create
  	@story = Story.new(params.permit(Story.column_names))
  	@story.save!
  	render json: @story.to_json
  end

  def update

  end

end