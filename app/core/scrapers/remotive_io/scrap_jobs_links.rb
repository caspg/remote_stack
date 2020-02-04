module Scrapers
  module RemotiveIo
    class ScrapJobsLinks
      JobLink = Struct.new(:id, :link, keyword_init: true)

      BASE_HOST = 'remotive.io'.freeze
      LIST_URL = 'https://remotive.io/remote-jobs/software-dev'.freeze

      def call
        job_list_items.map do |job_list_item|
          path = extract_path(job_list_item)

          JobLink.new(
            id: extract_job_id(path),
            link: build_link(path),
          )
        end
      end

      private

      def job_list_items
        document.xpath(
          '//li[contains(@class, "job-list-item")' \
          'and not(contains(@class, "job-list-dont-open"))]',
        ).take(5)
      end

      def document
        # TODO(kacper): maybe check if returns 200
        raw_document = HTTParty.get(LIST_URL)
        Nokogiri::HTML(raw_document.body)
      end

      def extract_path(job_list_item)
        job_list_item.attribute('data-url').value
      end

      def extract_job_id(path)
        path.split('-').last
      end

      def build_link(path)
        URI::HTTPS.build(host: BASE_HOST, path: path).to_s
      end
    end
  end
end
