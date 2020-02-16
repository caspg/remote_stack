# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_02_16_172711) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "author_type"
    t.bigint "author_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"
  end

  create_table "admin_users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "companies", force: :cascade do |t|
    t.string "name"
    t.string "slug", null: false
    t.index ["slug"], name: "index_companies_on_slug", unique: true
  end

  create_table "job_origins", force: :cascade do |t|
    t.string "name"
    t.index ["name"], name: "index_job_origins_on_name", unique: true
  end

  create_table "job_post_skills", force: :cascade do |t|
    t.bigint "skill_id"
    t.bigint "job_post_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["job_post_id"], name: "index_job_post_skills_on_job_post_id"
    t.index ["skill_id"], name: "index_job_post_skills_on_skill_id"
  end

  create_table "job_posts", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.string "origin_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "publication_datetime"
    t.string "apply_url"
    t.text "benefits"
    t.bigint "company_id"
    t.string "salary"
    t.bigint "job_origin_id"
    t.string "origin_url"
    t.index ["company_id"], name: "index_job_posts_on_company_id"
    t.index ["job_origin_id"], name: "index_job_posts_on_job_origin_id"
  end

  create_table "skills", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_skills_on_name", unique: true
  end

  add_foreign_key "job_posts", "companies"
  add_foreign_key "job_posts", "job_origins"

  create_view "job_post_searches", materialized: true, sql_definition: <<-SQL
      SELECT job_posts.id AS job_post_id,
      (((to_tsvector('english'::regconfig, (COALESCE(job_posts.title, ''::character varying))::text) || to_tsvector('english'::regconfig, COALESCE(job_posts.description, ''::text))) || to_tsvector('english'::regconfig, (COALESCE(companies.name, ''::character varying))::text)) || to_tsvector('english'::regconfig, COALESCE(string_agg((skills.name)::text, ' ; '::text), ''::text))) AS tsv_document
     FROM (((job_posts
       JOIN companies ON ((companies.id = job_posts.company_id)))
       JOIN job_post_skills ON ((job_post_skills.job_post_id = job_posts.id)))
       JOIN skills ON ((skills.id = job_post_skills.skill_id)))
    GROUP BY job_posts.id, companies.id;
  SQL
  add_index "job_post_searches", ["tsv_document"], name: "index_job_post_searches_on_tsv_document", using: :gin

end
