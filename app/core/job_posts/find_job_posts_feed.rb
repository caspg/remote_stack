module JobPosts
  class FindJobPostsFeed
    def self.call(page:, query:)
      JobPost
        .includes(:company, :skills)
        .where('publication_datetime > ?', 30.days.ago)
        .order(publication_datetime: :desc)
        .text_search(query)
        .page(page)
        .per(25)
    end
  end
end
