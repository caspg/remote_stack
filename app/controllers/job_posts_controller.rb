class JobPostsController < ApplicationController
  def show
    @job_post = JobPost.find(params[:id])
  end
end
