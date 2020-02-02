module Scrapers
  module StackOverflow
    class CreateJobPost
      ORIGIN_NAME = 'Stack Overflow'.freeze

      def initialize(rss_feed_item:, scraped_job_details:)
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

      attr_reader :rss_feed_item, :scraped_job_details

      def skills
        ::Skills::FindOrCreateSkills.new(skill_names: rss_feed_item.categories).call
      end

      def job_post
        @job_post ||= begin
          JobPost.create!(
            origin_name: ORIGIN_NAME,
            origin_id: rss_feed_item.id,
            title: scraped_job_details.title || rss_feed_item.title,
            description: rss_feed_item.description,
          )
        end
      end
    end
  end
end
