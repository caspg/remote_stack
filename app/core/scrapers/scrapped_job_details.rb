module Scrapers
  ScrappedJobDetails = Struct.new(
    :id,
    :job_origin_id,
    :title,
    :salary,
    :company_name,
    :benefits,
    :apply_url,
    :origin_url,
    :publication_datetime,
    :description,
    :categories,
    keyword_init: true,
  )
end
