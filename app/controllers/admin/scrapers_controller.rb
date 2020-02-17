module Admin
  class ScrapersController < ApplicationController
    # action responsible for scheduling scraping job
    def create
      validate_origin_name

      job_class.perform_async

      flash[:notice] = "#{params[:origin_name]} scraper scheduled just fine."
      redirect_to hq_root_path
    end

    private

    def validate_origin_name
      return if JobOrigin::NAMES.include?(params[:origin_name])

      raise "Unrecognized origin name: #{params[:origin_name]}"
    end

    def job_class
      case params[:origin_name]
      when JobOrigin::STACK_OVERFLOW
        ::Scrapers::StackOverflowJob
      when JobOrigin::WE_WORK_REMOTELY
        ::Scrapers::WeWorkRemotelyJob
      when JobOrigin::REMOTEIVE_IO
        ::Scrapers::RemotiveIoJob
      end
    end
  end
end
