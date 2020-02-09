class JobPost < ApplicationRecord
  has_many :job_post_skills
  has_many :skills, through: :job_post_skills

  belongs_to :company, optional: true

  validates :title, presence: true

  # TODO: add salary field
end

# == Schema Information
#
# Table name: job_posts
#
#  id                   :bigint           not null, primary key
#  benefits             :text
#  description          :text
#  link                 :string
#  origin_name          :string
#  publication_datetime :datetime
#  title                :string
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  company_id           :bigint
#  origin_id            :string
#
# Indexes
#
#  index_job_posts_on_company_id  (company_id)
#
# Foreign Keys
#
#  fk_rails_...  (company_id => companies.id)
#
