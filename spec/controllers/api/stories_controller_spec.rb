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
      post :create, {title: "Story X #{seed}", author: 'Author X', email: 'story@a.com', description: 'Story description'}
    end
    context 'ok' do
      it 'returns all stories' do
        expect(response.status).to eq 200
        story = Story.where(title: "Story X #{seed}")
        expect(story).to be_present
      end
    end
  end

end