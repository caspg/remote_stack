module Scrapers
  class RemotiveIoJob
    include SuckerPunch::Job

    def perform
      ::Scrapers.run_scraper(
        scraper_module: RemotiveIo,
        job_origin_name: JobOrigin::REMOTEIVE_IO,
      )
    end
  end
end
