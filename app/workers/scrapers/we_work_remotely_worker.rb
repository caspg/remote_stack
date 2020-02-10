module Scrapers
  class WeWorkRemotelyWorker
    include Sidekiq::Worker

    def perform
      ::Scrapers.run_scraper(
        scraper_module: WeWorkRemotely,
        job_origin_name: JobOrigin::WE_WORK_REMOTELY,
      )
    end
  end
end
