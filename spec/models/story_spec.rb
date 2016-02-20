require 'rails_helper'

RSpec.describe Story, type: :model do
  it "fails nothing is present" do
    expect(Story.create).to be_invalid
  end
  it "fails when email is invalid" do
    story = Story.create({author: 'me', title: 'title', email: 'notavalidemail'})
    expect(story).to be_invalid
  end
  it "adds a story when valid" do
    story = Story.create({author: 'me', title: 'title', email: 'valid@email.com'})
    expect(story).to be_valid
  end
end
