require 'rails_helper'

describe Api::StoriesController do
  describe 'GET #index' do
    before do
      get :index
    end
    context 'with params' do
      it 'returns all stories'
    end
  end
end