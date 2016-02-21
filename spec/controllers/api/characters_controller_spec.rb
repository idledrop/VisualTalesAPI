require 'rails_helper'

describe Api::CharactersController do

  describe 'GET #index' do
  	let(:story) { FactoryGirl.create(:story) }
    before do
    	10.times do |i|
          FactoryGirl.create(:character, name: "Character #{i}", story_id: story.id)
      end
      # Example:
      # GET /stories/1/characters
      get :index, story_id: story.id
    end
    context 'successful' do
      it 'gets list' do
        expect(response.status).to eq 200
        expect(JSON.parse(response.body).first.keys).to eq  ["id", "name", "description", "portrait", "story_id", "created_at", "updated_at"]
        expect(JSON.parse(response.body).size).to eq 10
      end
    end
  end

  describe 'GET #show' do
  	let(:story) { FactoryGirl.create(:story) }
  	let(:character) { FactoryGirl.create(:character, name: "Character x", story_id: story.id)}
    before do
      # Example:
      # GET /stories/1/characters/i
      get :show, story_id: story.id, id: character.id
    end
    context 'successful' do
      it 'gets details' do
        expect(response.status).to eq 200
        expect(JSON.parse(response.body).keys).to eq  ["id", "name", "description", "portrait", "story_id", "created_at", "updated_at", "poses"]
      end
    end
  end

  describe 'POST #create' do
  	let(:story) { FactoryGirl.create(:story) }
  	let(:attributes) { {name: 'whater white', description: 'description', portrait: fixture_file_upload('images/bob.jpg', 'image/jpg')} }
  	before do
      # Example:
      # POST /stories/1/characters/
      # "{\"name\":\"whater white\",\"description\":\"description\",\"portrait\":\"portrait\",\"story_id\":1212}"
      post :create, attributes.merge(story_id: story.id)
    end
    context 'successful' do
      it 'creates details' do
        expect(response.status).to eq 201
        expect(JSON.parse(response.body).keys).to eq  ["id", "name", "description", "portrait", "story_id", "created_at", "updated_at"]
      	c = Character.find(JSON.parse(response.body)['id'])
      	expect(c.name).to eq attributes[:name]
        expect(c.description).to eq attributes[:description]
      	expect(c.story_id).to eq story.id
        expect(c.portrait.class).to eq PortraitUploader
        expect(c.portrait.url.present?).to be_truthy
      end
    end
  end

  describe 'PUT #update' do

    let(:story) { FactoryGirl.create(:story) }
    let(:character) { FactoryGirl.create(:character,story_id: story.id) }
    let(:updated_attributes) { {name: 'whater white', description: 'description', portrait: fixture_file_upload('images/bob.jpg', 'image/jpg')} }
    before do
      # Example:
      # put /stories/storyid/characters/id
      # "{\"name\":\"whater white\",\"description\":\"description\",\"portrait\":\"portrait\",\"story_id\":1213,\"id\":188}"
		  put :update, updated_attributes.merge(story_id: story.id, id: character.id)
    end
    context 'successful' do
      it 'updates character' do
        # Response example
        # {"id":3,"title":"Story X 34674540-f608-4f0f-a2e6-7eec9d25b334","author":"Author X","email":"story@a.com","description":"Story description","created_at":"2016-02-20T19:11:43.072Z","updated_at":"2016-02-20T19:11:43.072Z\}
        expect(response.status).to eq 202
        reponse = JSON.parse(response.body)
        expect(JSON.parse(response.body).keys).to eq  ["id", "name", "description", "portrait", "story_id", "created_at", "updated_at"]
      	
        character.reload
        expect(character.name).to eq updated_attributes[:name]
        expect(character.description).to eq updated_attributes[:description]
      end
    end
  end 

  describe 'DELETE #destroy' do
    let(:story) { FactoryGirl.create(:story) }
    let(:character) { FactoryGirl.create(:character,story_id: story.id) }

    before do
      # Example:
      # put /stories/storyid/characters/id
      character
      expect(story.characters.size).to eq 1
      delete :destroy, story_id: story.id, id: character.id
    end
    context 'successful' do
      it 'deletes character' do
        expect(response.status).to eq 204 # no content
        expect(story.characters.reload.size).to eq 0
      end
    end
  end 

end