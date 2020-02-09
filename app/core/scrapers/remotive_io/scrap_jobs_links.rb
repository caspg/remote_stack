module Scrapers
  module RemotiveIo
    class ScrapJobsLinks
      JobLink = Struct.new(:id, :url, :publication_datetime, keyword_init: true)

      LIST_URL = 'https://remotive.io/remote-jobs/software-dev'.freeze

      def initialize(last_origin_id:)
        @last_origin_id = last_origin_id
      end

      def call
        job_links
          .take_while { |job_link| job_link.id != last_origin_id }
      end

      private

      attr_reader :last_origin_id

      def job_links
        job_list_items.map do |job_list_item|
          path = extract_path(job_list_item)

          JobLink.new(
            id: extract_job_id(path),
            url: build_url(path),
            publication_datetime: extract_publication_datetime(job_list_item),
          )
        end
      end

      def job_list_items
        document.xpath(
          '//li[contains(@class, "job-list-item")' \
          'and not(contains(@class, "job-list-dont-open"))]',
        )
      end

      def document
        @document ||= ::Scrapers::BaseScraper.new(LIST_URL)
      end

      def extract_path(job_list_item)
        job_list_item.attribute('data-url').value
      end

      def extract_job_id(path)
        path.split('-').last
      end

      def build_url(path)
        ::Scrapers::RemotiveIo.build_url(path)
      end

      def extract_publication_datetime(job_list_item)
        ::DateHelpers::ReverseWordsToDatetime.new(
          job_list_item.css('.job-date').first.text.strip,
        ).call
      end
    end
  end
end
