module Scrapers
  module RemotiveIo
    class ScrapJobsLinks
      JobLink = Struct.new(:id, :url, :publication_datetime, keyword_init: true)

      LIST_URL = 'https://remotive.io/remote-jobs/software-dev'.freeze

      def call
        job_list_items.map do |job_list_item|
          path = extract_path(job_list_item)

          JobLink.new(
            id: extract_job_id(path),
            url: build_url(path),
            publication_datetime: extract_publication_datetime(job_list_item),
          )
        end
      end

      private

      def job_list_items
        document.xpath(
          '//li[contains(@class, "job-list-item")' \
          'and not(contains(@class, "job-list-dont-open"))]',
        ).take_while.with_index do |_, index|
          index < 5
        end
        # TODO(kacper): ^^ remove that take_while and replace with "last_origin_id"
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
