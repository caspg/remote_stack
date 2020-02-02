class JobPost < ApplicationRecord
end

# == Schema Information
#
# Table name: job_posts
#
#  id          :bigint           not null, primary key
#  description :text
#  origin_name :string
#  title       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  origin_id   :string
#
