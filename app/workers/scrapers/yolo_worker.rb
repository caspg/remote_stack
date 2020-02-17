module Scrapers
  class YoloWorker
    include Sidekiq::Worker

    sidekiq_options retry: 0

    def perform
      Rails.logger.info('--------------------------------')
      Rails.logger.info('YOLO YOLO YOLO')
      Rails.logger.info('--------------------------------')
    end
  end
end
