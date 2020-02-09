class HomeController < ApplicationController
  def index
    @job_posts = home_page_job_posts
  end

  private

  def home_page_job_posts
    JobPost
      .where('publication_datetime > ?', 30.days.ago)
      .order(publication_datetime: :desc)
  end
end
