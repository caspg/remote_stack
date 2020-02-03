module Scrapers
  RssFeedItem = Struct.new(
    :id,
    :title,
    :publication_datetime,
    :link,
    :description,
    :categories,
    keyword_init: true,
  )
end
