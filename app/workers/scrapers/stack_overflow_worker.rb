module Scrapers
  class StackOverflowWorker
    def perform
      Rails.logger.info('starting Scrapers::StackOverflow')
      start = Time.now

      job_posts = ::Scrapers::StackOverflow
                  .scrap_and_create_job_posts(last_origin_id: last_origin_id)

      elapsed = Time.now - start
      size = job_posts.size

      Rails.logger.info(
        "Scrapers::StackOverflow run for #{elapsed} seconds and created #{size} job posts.",
      )
    end

    private

    def last_origin_id
      most_recent_job_post.origin_id
    end

    def most_recent_job_post
      JobPost.most_recent_for_origin(JobOrigin::STACK_OVERFLOW)
    end
  end
end
