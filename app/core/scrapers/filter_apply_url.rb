module Scrapers
  # Some job boards displays job ads from another origins (SO).
  # We don't want to include them
  # because separate scrapers are fetching those jobs.
  #
  # Usecases:
  # * apply_link redirects to another covered board (StackOverlfow etc)
  #   -> return nil
  # * apply_link redirects multiple time to some final job advert
  #   -> follow redirects and return url
  # * apply_link redirects and returns `/path/to/job`
  #   -> use last known hostname and return url
  # * apply link is or redirects to mailto:xxx@yyy.zz
  #   -> returns mailto:xxx@yyy.zz as apply url
  #
  class FilterApplyUrl
    IGNORED_HOSTNAMES = %w[
      stackoverflow.com
    ].freeze

    def initialize(apply_url:)
      Rails.logger.info("apply_url: #{apply_url}")

      @apply_url = apply_url
    end

    def call
      return nil if apply_url.nil?
      return apply_url if email_uri_str?(apply_url)
      return last_request_uri_str if email_uri_str?(last_request_uri_str)
      return nil if ignored_hostname?

      last_request_uri_str
    end

    private

    attr_reader :apply_url

    def ignored_hostname?
      IGNORED_HOSTNAMES.include?(last_request_uri.hostname)
    end

    def last_request_uri_str
      last_request_uri.to_s
    end

    def last_request_uri
      @last_request_uri ||= fetch_last_request_uri(apply_url)
    end

    def apply_uri
      URI(apply_url)
    end

    # https://ruby-doc.org/stdlib-2.7.0/libdoc/net/http/rdoc/Net/HTTP.html#class-Net::HTTP-label-Following+Redirection
    def fetch_last_request_uri(uri_str, limit = 5, prev_uri = nil)
      Rails.logger.info("uri_str: #{uri_str}")

      return apply_uri if uri_str.nil?
      return apply_uri if limit.zero?
      return uri_str if email_uri_str?(uri_str)

      current_uri = build_uri(uri_str, prev_uri)
      response = Net::HTTP.get_response(current_uri)
      handle_get_response(response, limit, current_uri, prev_uri)
    end

    def handle_get_response(http_response, limit, current_uri, prev_uri)
      case http_response
      when Net::HTTPSuccess
        http_response.uri
      when Net::HTTPRedirection
        location = http_response['location']
        fetch_last_request_uri(location, limit - 1, current_uri)
      else
        prev_uri || apply_uri
      end
    end

    def email_uri_str?(uri_str)
      uri_str.start_with?('mailto:') || uri_str =~ /@/
    end

    # there could be case when there is redirect to `/kuali/j/3D5D0753CF`
    def build_uri(uri_str, prev_uri)
      uri = URI(uri_str)

      return uri if uri.hostname.present?

      URI::HTTPS.build(host: prev_uri.hostname, path: uri.to_s)
    end
  end
end
