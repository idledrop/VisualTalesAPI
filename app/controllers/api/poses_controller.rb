class Api::PosesController < ApiController

	def index
		character = Character.where(story_id: params[:story_id],id: params[:character_id]).first
		render json: character.poses.all.to_json
	end

	def show
		character = Character.where(story_id: params[:story_id],id: params[:character_id]).first
		render json: character.poses.find(params[:id]).to_json
	end

	def create
  	pose = Pose.new(params.permit(:character_id,:name,:image))
  	pose.save!
  	render json: pose.to_json
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
	
end