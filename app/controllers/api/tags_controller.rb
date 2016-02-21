class Api::TagsController < ApiController

  def index
    if params[:story_id].present?
        tags = Story.find(params[:story_id]).tags
    else
      if params[:query].present?
        tags = Tag.where("name LIKE :query", query: "%#{params[:query].downcase.gsub(/\s+/, "")}%")
      else
        tags = Tag.all
      end
    end

    unless tags.empty?
      render json: tags
    else
      render nothing: true, status: :no_content
    end
  end


  def destroy
    tag = Tag.find(params[:id])

    tag.stories.delete(params[:story_id]) if params[:story_id].present?
    tag.destroy! unless params[:story_id].present?

    render status: :no_content, json: nil
  end

  def create
    code = :accepted
    if params[:id].present?
      tag = Tag.find(params[:id])
    elsif params[:name].present?
      if existing_tag = Tag.where(name: params[:name].downcase.gsub(/\s+/, "")).first
        tag = existing_tag
      else
        tag = Tag.create(name: params[:name].downcase.gsub(/\s+/, ""))
        code = :created
      end
    end

    if tag
      if params[:story_id].present?
        story = Story.find(params[:story_id])
        begin
          story.tags << tag
        rescue => e
          # Rescued to avoid error cause by enforcing uniqueness of StoryTags relationship
          # Hitting this block means that the relationship already exists.
          # It would be nice to know how to return the validation error.
        end
      end

      render json: tag, status: code, location: api_tag_url(tag)
    else
      head 422
    end
  end
end