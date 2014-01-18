require 'test_helper'

class WebComponentTest < ActiveSupport::TestCase
  #validates :name, :description, :githubLink, :type, :author, :demoLink, presence:true
  #validates :githubLink, :name, uniqueness:true
  setup do
    @user = users(:user1)
  end

  test "should not create a web component without attributes" do
    wc = WebComponent.new({})
    assert !wc.save
  end

  test "should create a webcomponent" do
    @user = users(:user1)

    wc = WebComponent.new({name:"web component 1", description: "description du web component 1", githubLink: "Link du web component", submitter: @user, demoLink: "https://www.github.com/repo.git", author: "me", type: "AngularJsWc", imageId: 1})
    assert wc.save
  end

  test "should not create a webcomponent without a submitter" do
    wc = WebComponent.new({name:"web component 1", description: "description du web component 1", githubLink: "Link du web component", demoLink: "https://www.github.com/repo.git", author: "me", type: "AngularJsWc", imageId: 1})
    assert !wc.save
  end
end
