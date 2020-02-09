module JobPosts
  class FindJobPostsFeed
    def self.call
      JobPost
        .includes(:company, :skills)
        .where('publication_datetime > ?', 30.days.ago)
        .order(publication_datetime: :desc)
    end
  end
end
