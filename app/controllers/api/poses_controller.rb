class Api::PosesController < ApiController

  before_action :fetch_character, :only => [:index, :create]
  before_action :fetch_pose, :only => [:update, :destroy]

	def index
		render json: @character.poses
	end

	def create
		pose = @character.poses.new(params.permit(:character_id,:name,:image))
  	if pose.save
			render json: pose, status: :created
		else
			render json:pose.errors, status: :unprocessable_entity
		end
  end

  def update
  	if @pose.update_attributes!(params.permit(:name,:image))
  		render json: @pose
		else
			render json: @pose.errors, status: :unprocessable_entity
		end
  end

	def destroy
		@pose.destroy
    render status: :no_content, json: nil
	end

  private

  def fetch_character
  	@character = Character.find(params[:character_id])
	end

  def fetch_pose
		@pose = Pose.find(params[:id])
	end
end