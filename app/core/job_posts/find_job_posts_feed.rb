module JobPosts
  class FindJobPostsFeed
    def self.call(page:)
      JobPost
        .includes(:company, :skills)
        .where('publication_datetime > ?', 30.days.ago)
        .order(publication_datetime: :desc)
        .page(page)
        .per(25)
    end
  end
end
