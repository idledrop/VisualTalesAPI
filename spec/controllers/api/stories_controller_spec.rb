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

  describe 'get #search' do

    let(:story_1) { FactoryGirl.create(:story, title: 'the godfather') }
    let(:story_2) { FactoryGirl.create(:story, title: 'star trek') }
    let(:story_3) { FactoryGirl.create(:story, title: 'star wars') }
    let(:story_4) { FactoryGirl.create(:story, title: 'casa blanca') }
    let(:tag_1) { FactoryGirl.create(:tag, name: 'horror') }
    let(:tag_2) { FactoryGirl.create(:tag, name: 'fiction') }
    let(:tag_3) { FactoryGirl.create(:tag, name: 'drama') }
    let(:tag_4) { FactoryGirl.create(:tag, name: 'thriller') }
    let(:story_tag_1) { FactoryGirl.create(:story_tag, story_id: story_1.id, tag_id: tag_3.id) }
    let(:story_tag_2) { FactoryGirl.create(:story_tag, story_id: story_1.id, tag_id: tag_4.id) }
    let(:story_tag_3) { FactoryGirl.create(:story_tag, story_id: story_2.id, tag_id: tag_2.id) }
    let(:story_tag_4) { FactoryGirl.create(:story_tag, story_id: story_3.id, tag_id: tag_2.id) }
    let(:story_tag_5) { FactoryGirl.create(:story_tag, story_id: story_3.id, tag_id: tag_3.id) }
    let(:story_tag_6) { FactoryGirl.create(:story_tag, story_id: story_4.id, tag_id: tag_3.id) }

    context 'by name' do
      before do
        story_tag_1;story_tag_2;story_tag_3;
        story_tag_4;story_tag_5;story_tag_6
        # Example:
        # GET /stories/search?title=star
        get :search, title: 'star'
      end
      it 'provides matches' do
        expect(response.status).to eq 200
         expect(JSON.parse(response.body).first.keys).to eq ["id", "title", "author", "email", "description", "created_at", "updated_at"]
        expect(JSON.parse(response.body).size).to eq 2
        expect(JSON.parse(response.body).map{|t| t['title']}).to eq ['star trek','star wars'] 
      end
    end

    context 'by tag_id' do
      before do
        story_tag_1;story_tag_2;story_tag_3;
        story_tag_4;story_tag_5;story_tag_6
        # Example:
        # GET /stories/search?tag_ids='1,2,3,4,5'
        get :search, tag_ids: [tag_2.id].join(',')
      end
      it 'provides matches' do
        expect(response.status).to eq 200
        expect(JSON.parse(response.body).first.keys).to eq ["id", "title", "author", "email", "description", "created_at", "updated_at"]
        expect(JSON.parse(response.body).size).to eq 2
        expect(JSON.parse(response.body).map{|t| t['title']}).to eq ['star trek','star wars'] 
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