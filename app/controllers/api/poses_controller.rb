class Api::PosesController < ApiController

  before_action :fetch_character, :only => [:index, :create]

	def index
		render json: @character.poses
	end

	def create
		pose = @character.poses.new(params.permit(:character_id,:name,:image))
  	if pose.save
			render json: pose
		else
			render json:pose.errors, status: :unprocessable_entity
		end
  end

  def update
  	character = Character.where(story_id: params[:story_id],id: params[:character_id]).first
  	pose = character.poses.find(params[:id])
  	pose.update_attributes!(params.permit(:name,:image))
  	render json: pose.to_json
  end

	def destroy
		character = Character.where(story_id: params[:story_id],id: params[:character_id]).first
  	pose = character.poses.find(params[:id])
		pose.destroy!
    render status: :no_content, json: nil
	end

  private

  def fetch_character
  	@character = Character.find(params[:character_id])
  end
end