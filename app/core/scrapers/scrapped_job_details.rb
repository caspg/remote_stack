module Scrapers
  ScrappedJobDetails = Struct.new(
    :id,
    :title,
    :salary,
    :company,
    :benefits,
    keyword_init: true,
  )
end
