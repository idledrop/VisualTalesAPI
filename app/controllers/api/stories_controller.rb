class Api::StoriesController < ApiController


  def index
    page_size = params[:page_size] || 25
    page =     params[:page] || 1
    tag_ids =   params[:tag_ids] || ''

    if params.except(*request.path_parameters.keys).empty?
       unless params[:tag_id]
         stories = Story.all
       else
         stories = Tag.find(params[:tag_id]).stories
       end
    else
        stories = Story
        if params[:title].present?
          stories = stories.where("title LIKE :query", query: "%#{params[:title]}%")
        end

        if params[:tag_id].present?
          ids = tag_ids.split(',') << params[:tag_id]
          tag_ids = ids.join(',')
        end

        unless tag_ids.blank?
          stories = stories.joins(:story_tags).where("story_tags.tag_id in (:tag_ids)", tag_ids: tag_ids.split(','))
        end
    end
   
    render json: stories.page(page).per(page_size)
  end

  def create
  	story = Story.new(params.permit(:title,:author,:email,:description))

    if story.save
  	  render json: story.to_json, status: :created, location: api_story_url(story)
    else
      render json: story.errors, status: :unprocessable_entity
    end
  end

  def update
  	story = Story.find(params[:id])
  	if story.update_attributes(params.permit(:title,:author,:description,:email))
  	  render json: story
    else
      render json: story.errors, status: :unprocessable_entity
    end
  end

  def show
    story = Story.find_by_id(params[:id])
    if story
      render json: story.to_json
    else
      head 404
    end
  end

end