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

  describe 'GET #search' do
    let(:tag_1) { FactoryGirl.create(:tag, name: 'horror') }
    let(:tag_2) { FactoryGirl.create(:tag, name: 'comedy fun') }
    let(:tag_3) { FactoryGirl.create(:tag, name: 'comedy bad') }
    before do
      tag_1
      tag_2
      tag_3
      # Example:
      # GET /tags?query=comedy
      get :index, query: 'comedy'
    end
    context 'successful' do
      it 'gets list of tags' do
        # Response example
        # "[{\"id\":53,\"name\":\"horror\",\"created_at\":\"2016-02-20T20:27:17.000Z\",\"updated_at\":\"2016-02-20T20:27:17.000Z\"},{\"id\":54,\"name\":\"fiction\",\"created_at\":\"2016-02-20T20:27:17.000Z\",\"updated_at\":\"2016-02-20T20:27:17.000Z\"}]"
        expect(response.status).to eq 200
        expect(JSON.parse(response.body).first.keys).to eq ["id","name","created_at","updated_at"] 
        expect(JSON.parse(response.body).size).to eq 2
        expect(JSON.parse(response.body).map{|t| t['name']}).to eq ['comedy fun','comedy bad']
      end
    end
  end

  describe 'DELETE #destroy' do
    let(:story) { FactoryGirl.create(:story) }
    let(:tag_1) { FactoryGirl.create(:tag, name: 'horror') }
    let(:story_tag_1) { FactoryGirl.create(:story_tag, story_id: story.id, tag_id: tag_1.id) }
    before do
      # Example:
      # DELETE /stories/1/tag/1
      story_tag_1
      expect(story.story_tags.size).to eq 1
      delete :destroy, id: story.id, tag_id: story_tag_1.tag_id
    end
    context 'successful' do
      it 'deletes story tag' do
        expect(response.status).to eq 204 # no content
        expect(story.story_tags.reload.size).to eq 0
      end
    end
  end

  describe 'GET #show' do
    let(:story) { FactoryGirl.create(:story) }
    let(:tag_1) { FactoryGirl.create(:tag, name: 'horror') }
    let(:tag_2) { FactoryGirl.create(:tag, name: 'comedy') }
    let(:story_tag_1) { FactoryGirl.create(:story_tag, story_id: story.id, tag_id: tag_1.id) }
    let(:story_tag_2) { FactoryGirl.create(:story_tag, story_id: story.id, tag_id: tag_2.id) }
    before do
      story_tag_1;story_tag_2
      # Example:
      # get /stories/1/tags/
      get :index, id: story.id
    end
    context 'successful' do
      it 'creates story tag' do
        # Response example
        # [{"id":16,"story_id":31,"tag_id":45,"created_at":"2016-02-20T20:13:02.772Z","updated_at":"2016-02-20T20:13:02.772Z"}]
        expect(response.status).to eq 200
        expect(JSON.parse(response.body).first.keys).to eq ["id","name","created_at","updated_at"]
        expect(JSON.parse(response.body).size).to eq 2
        expect(JSON.parse(response.body).map{|t| t['name']}).to eq ['horror','comedy']
      end
    end
  end

  describe 'POST #create' do
    let(:story) { FactoryGirl.create(:story) }
    let(:tag_1) { FactoryGirl.create(:tag, name: 'alreadyexisting') }

    context 'by numeric identifyer' do
      before do
        # Example:
        # POST /stories/1/tags/
        # BODY {"tags": 2}
        post :create, story_id: story.id, id: tag_1.id
      end
      it 'creates story tag by using id' do
        # Response example
        # {"id":16,"story_id":31,"tag_id":45,"created_at":"2016-02-20T20:13:02.772Z","updated_at":"2016-02-20T20:13:02.772Z"}
        expect(response.status).to eq 202
        expect(JSON.parse(response.body).keys).to eq ["id","name","created_at","updated_at"]
        expect(story.story_tags.reload.size).to eq 1
      end
    end
    context 'by tag text name - non existing' do
      before do
        # Example:
        # POST /stories/1/tag/
        # BODY {"tag": nonexistingtag}
        post :create, story_id: story.id, name: 'nonexistingtag'
      end
      it 'creates story tag and tag using name' do
        # Response example
        # {"id":16,"story_id":31,"tag_id":45,"created_at":"2016-02-20T20:13:02.772Z","updated_at":"2016-02-20T20:13:02.772Z"}
        expect(response.status).to eq 201
        expect(JSON.parse(response.body).keys).to eq ["id","name","created_at","updated_at"]
        expect(story.story_tags.reload.size).to eq 1
      end
    end
    context 'by tag text name - existing' do
      before do
        tag_1
        # Example:
        # POST /stories/1/tag/
        # BODY {"name": "alreadyexisting"}
        post :create, story_id: story.id, name: "alreadyexisting"
      end
      it 'creates story tag by finding existing tag by name' do
        # Response example
        # {"id":16,"story_id":31,"tag_id":45,"created_at":"2016-02-20T20:13:02.772Z","updated_at":"2016-02-20T20:13:02.772Z"}
        expect(response.status).to eq 202
        expect(JSON.parse(response.body).keys).to eq ["id","name","created_at","updated_at"]
        expect(story.story_tags.reload.size).to eq 1
        expect(story.story_tags.reload.first.tag.name).to eq 'alreadyexisting'
      end
    end
  end


end