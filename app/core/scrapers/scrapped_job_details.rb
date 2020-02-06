module Scrapers
  ScrappedJobDetails = Struct.new(
    :id,
    :title,
    :salary,
    :company,
    :benefits,
    :apply_url,
    :publication_datetime,
    :description,
    :categories,
    keyword_init: true,
  )
end
