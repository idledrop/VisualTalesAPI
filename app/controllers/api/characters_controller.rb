class Api::CharactersController < ApiController
	
	def index
		story = Story.find(params[:story_id])
		render json: story.characters.all.to_json
	end

	def show
		story = Story.find(params[:story_id])
		render json: story.characters.find(params[:id]).to_json
	end

	def create
  	character = Character.new(params.permit(:name,:description,:portrait))
  	character.save!
  	render json: character.to_json
  end

  def update
  	character = Character.where(id: params[:id],story_id: params[:story_id]).first
  	character.update_attributes!(params.permit(:name,:description,:portrait))
  	render json: character.to_json
  end

	def destroy
		character = Character.where(id: params[:id],story_id: params[:story_id]).first
    character.destroy!
    render status: :no_content, json: nil
	end

end