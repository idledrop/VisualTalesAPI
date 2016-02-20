class Api::StoryTagsController < ApiController

  def create
  	story = Story.find(params[:story_id])
  	created_story_tags = []
  	ActiveRecord::Base.transaction do
  		created_story_tags = params[:tags].map do |tag|
  			story.story_tags.create!(tag_id: tag[:tag_id])
  		end
		end
  	render json: created_story_tags.to_json
  end

end