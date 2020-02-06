module Scrapers
  module RemotiveIo
    BASE_HOST = 'remotive.io'.freeze

    class << self
      def build_url(path)
        return nil if path.nil?
        URI::HTTPS.build(host: BASE_HOST, path: path).to_s
      end
    end
  end
end
