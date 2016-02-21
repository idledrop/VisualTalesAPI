require 'rails_helper'

describe Api::PosesController do

  describe 'GET #index' do
  	let(:story) { FactoryGirl.create(:story) }
  	let(:character) { FactoryGirl.create(:character,story_id: story.id) }
    before do
    	10.times do |i|
          FactoryGirl.create(:pose, name: "Pose #{i}", image: 'image', character_id: character.id)
      end
      # Example:
      # GET /stories/1/characters/1/poses
      get :index, character_id: character.id
    end
    context 'successful' do
      it 'gets list' do
        expect(response.status).to eq 200
        expect(JSON.parse(response.body).first.keys).to eq  ["id", "name", "image", "character_id", "created_at", "updated_at"]
        expect(JSON.parse(response.body).size).to eq 10
      end
    end
  end


  describe 'POST #create' do
    let(:story) { FactoryGirl.create(:story) }
  	let(:character) { FactoryGirl.create(:character,story_id: story.id) }
  	let(:attributes) { {name: 'whater white', image: 'image', character_id: character.id} }
  	before do
      # Example:
      # POST /stories/1/characters/1/poses/
		  post :create, attributes.merge(story_id: story.id,character_id: character.id)
    end
    context 'successful' do
      it 'creates details' do
        expect(response.status).to eq 201
        expect(JSON.parse(response.body).keys).to eq  ["id", "name", "image", "character_id", "created_at", "updated_at"]
      	c = Pose.find(JSON.parse(response.body)['id'])
      	c.name = attributes[:name]
      	c.image = attributes[:image]
      	c.character_id = attributes[:character_id]
      end
    end
  end

  describe 'PUT #update' do
 		let(:story) { FactoryGirl.create(:story) }
  	let(:character) { FactoryGirl.create(:character,story_id: story.id) }
    let(:pose) { FactoryGirl.create(:pose,character_id: character.id) }
    let(:updated_attributes) { {name: 'name x', image: 'image x'} }
    before do
      # Example:
      # put /stories/storyid/characters/id/1
		  put :update, updated_attributes.merge(story_id: story.id, character_id: character.id, id: pose.id)
    end
    context 'successful' do
      it 'updates character' do
        expect(response.status).to eq 200
        reponse = JSON.parse(response.body)
        expect(JSON.parse(response.body).keys).to eq  ["id", "name", "image", "character_id", "created_at", "updated_at"]
      	
        pose.reload
        expect(pose.name).to eq updated_attributes[:name]
      end
    end
  end 

  describe 'DELETE #destroy' do
    let(:story) { FactoryGirl.create(:story) }
  	let(:character) { FactoryGirl.create(:character,story_id: story.id) }
    let(:pose) { FactoryGirl.create(:pose,character_id: character.id) }
    
    before do
      # Example:
      # put /stories/storyid/characters/id/pose/1
      pose
      expect(character.poses.size).to eq 1
      delete :destroy, id: pose.id
    end
    context 'successful' do
      it 'deletes' do
        expect(response.status).to eq 204 # no content
        expect(character.poses.reload.size).to eq 0
      end
    end
  end 

end