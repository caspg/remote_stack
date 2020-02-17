module Scrapers
  class StackOverflowJob
    include SuckerPunch::Job

    def perform
      ::Scrapers.run_scraper(
        scraper_module: StackOverflow,
        job_origin_name: JobOrigin::STACK_OVERFLOW,
      )
    end
  end
end
