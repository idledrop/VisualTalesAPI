class Api::CharactersController < ApiController

  before_action :fetch_story, only: [:index, :create]
  before_action :fetch_character, only: [:show]
	
	def index
		characters = @story.characters

		unless characters.empty?
			render json: characters
		else
			render nothing: true, status: :no_content
		end
	end

	def show
		render json: @character.as_json(only:[:id, :name, :description, :portrait, :story_id, :created_at, :updated_at],
																		include: { poses: { only: [:id, :name, :image]}
																							}
																		)
	end

	def create
			character = @story.characters.new(params.permit(:name,:description,:portrait))
			if character.save
				render json: character.to_json, status: :created, location: api_character_url(character)
			else
				render json: character.errors, status: :unprocessable_entity
			end
  end

  def update
  	character = Character.find(params[:id])
  	if character.update_attributes!(params.permit(:name,:description,:portrait))
  		render json: character.to_json, status: :accepted
		else
			render character.errors, status: :unprocessable_entity
		end
  end

	def destroy
		character = Character.find_by_id(params[:id])
    character.destroy!
    render status: :no_content, json: nil
	end

	private

	def fetch_story
		@story = Story.find(params[:story_id])
	end

  def fetch_character
		@character = Character.find(params[:id])
	end


end