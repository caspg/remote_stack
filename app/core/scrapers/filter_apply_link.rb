module Scrapers
  # Some job boards displays job ads from another origins (SO).
  # We don't want to include them
  # because separate scrapers are fetching those jobs.
  #
  # If given link redirects to that boards, it returns nil,
  # otherwise it returns link to `apply` website.
  class FilterApplyLink
    IGNORED_HOSTNAMES = %w[
      stackoverflow.com
    ].freeze

    def initialize(apply_link:)
      @apply_link = apply_link
    end

    def call
      return nil if ignored_hostname?

      last_request_uri.to_s
    end

    private

    attr_reader :apply_link

    def ignored_hostname?
      IGNORED_HOSTNAMES.include?(last_request_uri.hostname)
    end

    def last_request_uri
      response.request.last_uri
    end

    def response
      HTTParty.get(apply_link, follow_redirects: true)
    end
  end
end
