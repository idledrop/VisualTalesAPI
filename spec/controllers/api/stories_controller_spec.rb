require 'rails_helper'

describe Api::StoriesController do
  describe 'GET #index' do
    before do
      get :index
    end
    context 'with no params' do
      it 'returns all stories' do
        expect(response.status).to eq 200
      end
    end
  end

  describe 'POST #create' do
    let(:seed) { SecureRandom.uuid }
    before do
      # Example:
      # POST /stories 
      # BODY {"title":"Story X ff0e3a61-3e53-437c-af00-d18674f68679","author":"Author X","email":"story@a.com","description":"Story description"} 
      post :create, {title: "Story X #{seed}", author: 'Author X', email: 'story@a.com', description: 'Story description'}
    end
    context 'successful' do
      it 'creates story' do
        # Response example
        # {"id":3,"title":"Story X 34674540-f608-4f0f-a2e6-7eec9d25b334","author":"Author X","email":"story@a.com","description":"Story description","created_at":"2016-02-20T19:11:43.072Z","updated_at":"2016-02-20T19:11:43.072Z\}
        expect(response.status).to eq 200
        expect(JSON.parse(response.body).keys).to eq ["id", "title", "author", "email", "description", "created_at", "updated_at"]
        story = Story.where(title: "Story X #{seed}")
        expect(story).to be_present
      end
    end
  end

end