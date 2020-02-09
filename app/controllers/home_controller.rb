class HomeController < ApplicationController
  def index
    @job_posts = job_posts_feed
  end

  private

  def job_posts_feed
    ::JobPosts::FindJobPostsFeed.call
  end
end
