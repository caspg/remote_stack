module Scrapers
  class CreateJobPost
    def initialize(origin_name:, rss_feed_item:, scraped_job_details:)
      @origin_name = origin_name
      @rss_feed_item = rss_feed_item
      @scraped_job_details = scraped_job_details
    end

    def call!
      skills.each do |skill|
        JobPostSkill.create!(skill: skill, job_post: job_post)
      end

      job_post
    end

    private

    attr_reader :origin_name, :rss_feed_item, :scraped_job_details

    def skills
      return [] if rss_feed_item.categories.blank?

      ::Skills::FindOrCreateSkills.new(skill_names: rss_feed_item.categories).call
    end

    def job_post
      @job_post ||= JobPost.create!(job_post_params)
    end

    # rubocop:disable Metrics/AbcSize
    def job_post_params
      {
        origin_id: rss_feed_item.id,
        origin_name: origin_name,
        benefits: scraped_job_details.benefits,
        title: scraped_job_details.title || rss_feed_item.title,
        description: rss_feed_item.description,
        publication_datetime: rss_feed_item.publication_datetime,
        link: rss_feed_item.link,
        company: company,
      }
    end
    # rubocop:enable Metrics/AbcSize

    def company
      return nil if scraped_job_details.company.nil?

      ::Companies::FindOrCreateCompany.new(company_name: scraped_job_details.company).call
    end
  end
end
