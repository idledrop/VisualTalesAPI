class Api::StoryTagsController < ApiController

  def create
  	story_tag = StoryTag.new(story_id: params[:story_id],tag_id: params[:tag_id])
    story_tag.save!
  	render json: story_tag.to_json
  end

  def destroy
    story_tag = StoryTag.find(params[:id])
    story_tag.destroy!
    render status: :no_content, json: nil
  end

end