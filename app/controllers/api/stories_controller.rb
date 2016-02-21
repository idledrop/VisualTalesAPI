class Api::StoriesController < ApiController

  def index
    page_size = params[:page_size] || 25
    page =     params[:page] || 1

    if params.except(*request.path_parameters.keys).empty?
       stories = Story.all
    else
      stories = Story
      if params[:title].present?
        stories = stories.where("title LIKE :query", query: "%#{params[:title]}%")
      end
      if params[:tag_ids].present?
        stories = stories.joins(:story_tags).where("story_tags.tag_id in (:tag_ids)", tag_ids: params[:tag_ids].split(','))
      end
    end
   
    render json: stories.page(page).per(page_size)
  end

  def create
  	@story = Story.new(params.permit(Story.column_names))
  	@story.save!
  	render json: @story.to_json
  end

  def update
  	story = Story.find(params[:id])
  	story.update_attributes!(params.permit(:title,:author,:description,:email))
  	render json: story.to_json
  end

  def tags
    render json: Story.find(params[:id]).tags.to_json
  end

  def tag

    if !!(params.require(:tag) =~ /\A[-+]?[0-9]+\z/) # is a number?
      tag_id = params[:tag_id]
    else 
      if existing_tag = Tag.where(name: params[:tag]).first
        tag_id = existing_tag.id
      else
        new_tag = Tag.new(name: params[:tag].downcase.gsub(/\s+/, ""))
        tag_id = new_tag.id
      end
    end

    story_tag = StoryTag.new(story_id: params[:id],tag_id: tag_id)
    story_tag.save!
    
    render json: story_tag.to_json
  end

  def destroy_tag
    story_tag = Story.find(params[:id]).story_tags.where(tag_id: params[:tag_id]).first
    story_tag.destroy!
    render status: :no_content, json: nil
  end

end