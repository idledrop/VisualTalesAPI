require 'rails_helper'

describe Api::StoryTagsController do
  let(:story) { FactoryGirl.create(:story) }
  let(:tag_1) { FactoryGirl.create(:tag, name: 'horror') }
  let(:story_tag_1) { FactoryGirl.create(:story_tag, story_id: story.id, tag_id: tag_1.id) }
  
  describe 'POST #create' do
    before do
      # Example:
      # POST /stories/1/tags/ 
      # BODY {"tag_id": 2}
      post :create, story_id: story.id, tag_id: tag_1.id
    end
    context 'successful' do
      it 'creates story tag' do
        # Response example
        # {"id":16,"story_id":31,"tag_id":45,"created_at":"2016-02-20T20:13:02.772Z","updated_at":"2016-02-20T20:13:02.772Z"}
        expect(response.status).to eq 200
        expect(JSON.parse(response.body).keys).to eq ["id","story_id","tag_id","created_at","updated_at"] 
        expect(story.story_tags.size).to eq 1
      end
    end
  end

  describe 'DELETE #destroy' do
    before do
      # Example:
      # DELETE /stories/1/tags/1
      delete :destroy, story_id: story.id, id: story_tag_1.id
    end
    context 'successful' do
      it 'creates story tag' do
        # Response example
        #
        expect(response.status).to eq 204
        expect(story.story_tags.reload.size).to eq 0
      end
    end
  end

end