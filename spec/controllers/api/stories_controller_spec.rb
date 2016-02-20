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

end