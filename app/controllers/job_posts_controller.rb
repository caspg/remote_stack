class JobPostsController < ApplicationController
  def show
    @job_post = JobPost.find(params[:id])

    fresh_when(etag: @job_post, last_modified: @job_post.updated_at.utc, public: true)
  end
end
