module Scrapers
  module RemotiveIo
    class ScrapJobDetails
      def initialize(job_link:)
        @job_link = job_link
      end

      def call
        return nil if filtered_apply_link.nil?

        ::Scrapers::ScrappedJobDetails.new(
          id: job_link.id,
          title: title,
          company: company,
          apply_url: apply_url,
          publication_datetime: job_link.publication_datetime || DateTime.now,
          description: description,
          categories: categories,
        )
      end

      private

      attr_reader :job_link

      def filtered_apply_link
        @filtered_apply_link ||=
          ::Scrapers::FilterApplyUrl.new(apply_url: apply_url).call
      end

      def apply_url
        ::Scrapers::RemotiveIo.build_url(apply_path)
      end

      def apply_path
        document.css('.apply-wrapper a').first&.attribute('href')&.value
      end

      def document
        @document ||= ::Scrapers::BaseScraper.new(job_link.url)
      end

      def title
        document.css('.wrapper .content h1').first.text
      end

      def company
        document.css('.company').first.text
      end

      def description
        document.css('.job-description').first.to_xml
      end

      def categories
        document.css('.job-tag').map { |el| el.text.strip }
      end
    end
  end
end
