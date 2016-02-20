require 'rails_helper'

describe Api::StoryTagsController do

  describe 'POST #create' do
  	let(:story) { FactoryGirl.create(:story) }
  	let(:tag_1) { FactoryGirl.create(:tag, name: 'horror') }
  	let(:tag_2) { FactoryGirl.create(:tag, name: 'fiction') }
    before do
      # Example:
      # POST /stories/1/tags/ 
      # BODY [{"tag_id": 2},{"tag_id": 3}]
      post :create, story_id: story.id, tags: [{tag_id: tag_1.id},{tag_id: tag_2.id}]
    end
    context 'successful' do
      it 'creates story tag' do
        # Response example
        # [{"id":16,"story_id":31,"tag_id":45,"created_at":"2016-02-20T20:13:02.772Z","updated_at":"2016-02-20T20:13:02.772Z"},{"id":17,"story_id":31,"tag_id":46,"created_at":"2016-02-20T20:13:04.560Z","updated_at":"2016-02-20T20:13:04.560Z"}] 
        expect(response.status).to eq 200
        expect(JSON.parse(response.body).first.keys).to eq ["id","story_id","tag_id","created_at","updated_at"] 
        expect(story.story_tags.size).to eq 2
      end
    end
  end

end