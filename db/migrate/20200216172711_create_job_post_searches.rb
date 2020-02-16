class CreateJobPostSearches < ActiveRecord::Migration[6.0]
  def change
    create_view :job_post_searches, materialized: true
    add_index :job_post_searches, :tsv_document, using: :gin
    add_index :job_post_searches, :job_post_id, unique: true
  end
end
