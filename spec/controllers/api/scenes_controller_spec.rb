require 'rails_helper'

describe Api::ScenesController, type: :controller do
  describe 'GET #index' do
    let(:story) { FactoryGirl.create(:story) }
    let(:story2) { FactoryGirl.create(:story) }
    before do
      10.times do |i|
        FactoryGirl.create(:scene, name: "Scene #{i}", description: 'some thing', background: 'image', order: i, story_id: story.id)
      end
      # Example:
      # GET /stories/1/characters/1/poses
      get :index, story_id: story.id
    end
    context 'successful' do
      it 'gets list' do
        expect(response.status).to eq 200
        expect(JSON.parse(response.body).first.keys).to eq  ["id", "name", "description", "background", "story_id", "order", "created_at", "updated_at"]
        expect(JSON.parse(response.body).size).to eq 10
      end
    end
  end

  describe 'POST #create' do
    let(:story) { FactoryGirl.create(:story) }
    let(:attributes) { {name: 'name', description: 'som desc', background: 'image', order: 1} }
    before do
      # Example:
      # POST /stories/1/scenes
      post :create, attributes.merge(story_id: story.id)
    end
    context 'successful' do
      it 'creates details' do
        expect(response.status).to eq 201
        expect(JSON.parse(response.body).keys).to eq  ["id", "name", "description", "background", "story_id", "order", "created_at", "updated_at"]
        c = Scene.find(JSON.parse(response.body)['id'])
        c.name = attributes[:name]
        c.background = attributes[:background]
        c.order = attributes[:order]
      end
    end
  end

  describe 'PUT #update' do
    let(:story) { FactoryGirl.create(:story) }
    let(:scene) { FactoryGirl.create(:scene, name: 'name', description: 'som desc', background: 'image', order: 1, story_id: story.id) }
    let(:updated_attributes) { {name: 'AK', order: 2} }
    before do
      # Example:
      # put /stories/storyid/characters/id/1
      put :update, updated_attributes.merge(id: scene.id)
    end
    context 'successful' do
      it 'updates character' do
        expect(response.status).to eq 200
        reponse = JSON.parse(response.body)
        expect(JSON.parse(response.body).keys).to eq  ["id", "name", "description", "background", "story_id", "order", "created_at", "updated_at"]

        scene.reload
        expect(scene.name).to eq updated_attributes[:name]
      end
    end
  end

  describe 'DELETE #destroy' do
    let(:story) { FactoryGirl.create(:story) }
    let(:scene) { FactoryGirl.create(:scene, name: 'name', description: 'som desc', background: 'image', order: 1, story_id: story.id) }

    before do
      # Example:
      # put /stories/storyid/characters/id/pose/1
      scene
      expect(story.scenes.size).to eq 1
      delete :destroy, id: scene.id
    end
    context 'successful' do
      it 'deletes' do
        expect(response.status).to eq 204 # no content
        expect(story.scenes.reload.size).to eq 0
      end
    end
  end
end
