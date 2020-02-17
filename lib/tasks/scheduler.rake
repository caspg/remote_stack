task scrap_stack_overflow: :environment do
  ::Scrapers.run_scraper(
    scraper_module: ::Scrapers::StackOverflow,
    job_origin_name: ::JobOrigin::STACK_OVERFLOW,
  )
end

task scrap_we_work_remotely: :environment do
  ::Scrapers.run_scraper(
    scraper_module: ::Scrapers::WeWorkRemotely,
    job_origin_name: Scrapers::JobOrigin::WE_WORK_REMOTELY,
  )
end

task scrap_remotive: :environment do
  ::Scrapers.run_scraper(
    scraper_module: ::Scrapers::RemotiveIo,
    job_origin_name: JobOrigin::REMOTEIVE_IO,
  )
end
