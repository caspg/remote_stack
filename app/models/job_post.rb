class JobPost < ApplicationRecord
  has_many :job_post_skills, dependent: :destroy
  has_many :skills, through: :job_post_skills

  belongs_to :company, optional: true
  belongs_to :job_origin

  validates :title, presence: true
  validates :apply_url, presence: true

  class << self
    def text_search(query)
      if query.present?
        where(id: JobPostSearch.search(query).select(:job_post_id))
      else
        all
      end
    end

    def most_recent
      order('publication_datetime').last
    end

    def most_recent_for_origin(job_origin_name)
      joins(:job_origin)
        .where(job_origins: { name: job_origin_name })
        .most_recent
    end
  end
end

# == Schema Information
#
# Table name: job_posts
#
#  id                   :bigint           not null, primary key
#  apply_url            :string
#  benefits             :text
#  description          :text
#  origin_url           :string
#  publication_datetime :datetime
#  salary               :string
#  title                :string
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  company_id           :bigint
#  job_origin_id        :bigint
#  origin_id            :string
#
# Indexes
#
#  index_job_posts_on_company_id            (company_id)
#  index_job_posts_on_job_origin_id         (job_origin_id)
#  index_job_posts_on_publication_datetime  (publication_datetime)
#
# Foreign Keys
#
#  fk_rails_...  (company_id => companies.id)
#  fk_rails_...  (job_origin_id => job_origins.id)
#
