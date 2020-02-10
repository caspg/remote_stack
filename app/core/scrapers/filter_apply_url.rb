module Scrapers
  # Some job boards displays job ads from another origins (SO).
  # We don't want to include them
  # because separate scrapers are fetching those jobs.
  #
  # If given link redirects to that boards, it returns nil,
  # otherwise it returns link to `apply` website.
  class FilterApplyUrl
    IGNORED_HOSTNAMES = %w[
      stackoverflow.com
    ].freeze

    def initialize(apply_url:)
      @apply_url = apply_url
    end

    def call
      return nil if apply_url.nil?
      return apply_url if email_uri?(apply_url)
      return nil if ignored_hostname?

      last_request_uri.to_s
    end

    private

    attr_reader :apply_url

    def ignored_hostname?
      IGNORED_HOSTNAMES.include?(last_request_uri.hostname)
    end

    def last_request_uri
      fetch_last_request_uri(apply_url)
    end

    # https://ruby-doc.org/stdlib-2.7.0/libdoc/net/http/rdoc/Net/HTTP.html#class-Net::HTTP-label-Following+Redirection
    # rubocop:disable Metrics/MethodLength
    def fetch_last_request_uri(uri_str, limit = 5)
      return apply_uri if limit.zero?
      return uri_str if email_uri?(uri_str)

      response = Net::HTTP.get_response(URI(uri_str))

      case response
      when Net::HTTPSuccess
        response.uri
      when Net::HTTPRedirection
        location = response['location']
        fetch_last_request_uri(location, limit - 1)
      else
        apply_uri
      end
    end
    # rubocop:enable Metrics/MethodLength

    def apply_uri
      URI(apply_url)
    end

    def email_uri?(uri_str)
      uri_str.start_with?('mailto:') || uri_str =~ /@/
    end
  end
end
