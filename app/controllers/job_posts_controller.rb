class JobPostsController < ApplicationController
  def index
    @job_posts = ::JobPosts::FindJobPostsFeed.call(
      page: params[:page],
      query: params[:query],
    )
  end

  def show
    @job_post = JobPost.find(params[:id])

    fresh_when(etag: @job_post, last_modified: @job_post.updated_at.utc, public: true)
  end
end
