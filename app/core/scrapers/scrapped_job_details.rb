module Scrapers
  ScrappedJobDetails = Struct.new(
    :id,
    :origin_name,
    :title,
    :salary,
    :company_name,
    :benefits,
    :apply_url,
    :publication_datetime,
    :description,
    :categories,
    keyword_init: true,
  )
end
