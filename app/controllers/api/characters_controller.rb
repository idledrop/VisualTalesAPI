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
		if params[:story_id]
			story = Story.find(params[:story_id])
			character = story.characters.new(params.permit(:name,:description,:portrait))
			if character.save
				render json: character.to_json, status: :created, location: api_character_url(character)
			else
				render json: character.errors, status: :unprocessable_entity
			end
		else
			render json: {story_id: 'must be included in url'}.to_json, status: :unprocessable_entity
		end
  end

  def update
  	character = Character.find(params[:id])
  	if character.update_attributes!(params.permit(:name,:description,:portrait))
  		render json: character.to_json
		else
			render character.errors, status: :unprocessable_entity
		end
  end

	def destroy
		character = Character.find_by_id(params[:id])
    character.destroy!
    render status: :no_content, json: nil
	end

end