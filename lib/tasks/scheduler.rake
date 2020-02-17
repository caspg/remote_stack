task scrap_stack_overflow: :environment do
  ::Scrapers.run_scraper(
    scraper_module: StackOverflow,
    job_origin_name: JobOrigin::STACK_OVERFLOW,
  )
end

task scrap_we_work_remotely: :environment do
  ::Scrapers.run_scraper(
    scraper_module: WeWorkRemotely,
    job_origin_name: JobOrigin::WE_WORK_REMOTELY,
  )
end

task scrap_remotive: :environment do
  ::Scrapers.run_scraper(
    scraper_module: RemotiveIo,
    job_origin_name: JobOrigin::REMOTEIVE_IO,
  )
end
