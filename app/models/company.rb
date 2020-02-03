class Company < ApplicationRecord
  validates :name, presence: true
  validates :slug, presence: true
end

# == Schema Information
#
# Table name: companies
#
#  id   :bigint           not null, primary key
#  name :string
#  slug :string           not null
#
# Indexes
#
#  index_companies_on_slug  (slug) UNIQUE
#
