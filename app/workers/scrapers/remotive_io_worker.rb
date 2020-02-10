module Scrapers
  class RemotiveIoWorker
    include Sidekiq::Worker

    def perform
      ::Scrapers.run_scraper(
        scraper_module: RemotiveIo,
        job_origin_name: JobOrigin::STACK_OVERFLOW,
      )
    end
  end
end
