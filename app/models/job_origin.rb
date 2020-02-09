class JobOrigin < ApplicationRecord
  has_many :job_posts

  validates :name, presence: true

  STACK_OVERFLOW = 'Stack Overflow'.freeze
  WE_WORK_REMOTELY = 'We Work Remotely'.freeze
  REMOTEIVE_IO = 'RemotiveIo'.freeze

  NAMES = [STACK_OVERFLOW, WE_WORK_REMOTELY, REMOTEIVE_IO].freeze
end

# == Schema Information
#
# Table name: job_origins
#
#  id   :bigint           not null, primary key
#  name :string
#
# Indexes
#
#  index_job_origins_on_name  (name) UNIQUE
#
