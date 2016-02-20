require 'rails_helper'

describe Api::TagsController do

  describe 'GET #index' do
  	let(:tag_1) { FactoryGirl.create(:tag, name: 'horror') }
  	let(:tag_2) { FactoryGirl.create(:tag, name: 'fiction') }
    before do
    	tag_1
    	tag_2
      # Example:
      # GET /tags
      get :index
    end
    context 'successful' do
      it 'gets list of tags' do
      	# Response example
      	# "[{\"id\":53,\"name\":\"horror\",\"created_at\":\"2016-02-20T20:27:17.000Z\",\"updated_at\":\"2016-02-20T20:27:17.000Z\"},{\"id\":54,\"name\":\"fiction\",\"created_at\":\"2016-02-20T20:27:17.000Z\",\"updated_at\":\"2016-02-20T20:27:17.000Z\"}]"
        expect(response.status).to eq 200
        expect(JSON.parse(response.body).first.keys).to eq ["id","name","created_at","updated_at"] 
        expect(JSON.parse(response.body).size).to eq 2
      end
    end
  end

end