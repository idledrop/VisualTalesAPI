class Api::ScenesController < ApiController

  before_action :fetch_story, :only => [:index, :create]
  before_action :fetch_scene, :only => [:update, :destroy]

  def index
    scenes = @story.scenes

    unless scenes.empty?
      render json: @story.scenes
    else
      render nothing: true, status: :no_content
    end
  end

  def create
     scene = @story.scenes.new(params.permit(:name,:description,:background,:order))
     if scene.save
      render json: scene, status: :created, location: api_scene_url(scene)
    else
      render json: scene.errors, status: :unprocessable_entity
    end
  end

  def update
    if @scene.update_attributes(params.permit(:name, :description, :background, :order))
      render json: @scene, location: api_scene_url(@scene)
    else
      render json: @scene.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @scene.destroy
    render nothing: true, status: :no_content
  end


  private
  def fetch_story
    @story = Story.find(params[:story_id])
  end

  def fetch_scene
    @scene = Scene.find(params[:id])
  end

end
