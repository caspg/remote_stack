module Scrapers
  ScrappedJobDetails = Struct.new(
    :id,
    :origin_name,
    :title,
    :salary,
    :company_name,
    :benefits,
    :link,
    :publication_datetime,
    :description,
    :categories,
    keyword_init: true,
  )
end
