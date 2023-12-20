require 'rails_helper'

RSpec.describe 'Post Show Page', type: :feature do
  fixtures :users, :posts, :comments

  before do
    @post = posts(:first_post)
    visit post_path(@post)
  end

  it "I can see the post's title" do
    expect(page).to have_content(@post.title)
  end

  it 'I can see who wrote the post' do
    expect(page).to have_content("Post #{@post.id} by #{@post.author.name}")
  end

  it 'I can see how many comments it has' do
    expect(page).to have_content("Comments: #{@post.comments.count}")
  end

  it 'I can see how many likes it has' do
    expect(page).to have_content("Likes #{@post.likes.count}")
  end

  it 'I can see the post body' do
    expect(page).to have_content(@post.text)
  end

  it 'I can see the username of each commentator' do
    @post.comments.each do |comment|
      expect(page).to have_content(comment.user.name)
    end
  end

  it 'I can see the comment each commentator left' do
    @post.comments.each do |comment|
      expect(page).to have_content(comment.text)
    end
  end
end
