module Scrapers
  class CreateJobPost
    def initialize(job_details:)
      @job_details = job_details
    end

    def call!
      skills.each do |skill|
        JobPostSkill.create!(skill: skill, job_post: job_post)
      end

      job_post
    end

    private

    attr_reader :job_details

    def skills
      return [] if job_details.categories.blank?

      ::Skills::FindOrCreateSkills.new(skill_names: job_details.categories).call
    end

    def job_post
      @job_post ||= JobPost.create!(job_post_params)
    end

    def job_post_params
      job_details
        .to_h
        .merge(company: company, origin_id: job_details.id)
        .except(:company_name, :categories, :id)
    end

    def company
      return nil if job_details.company_name.nil?

      ::Companies::FindOrCreateCompany.new(company_name: job_details.company_name).call
    end
  end
end
