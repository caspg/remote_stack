module Companies
  class FindOrCreateCompany
    def initialize(company_name:)
      @company_name = company_name
    end

    def call
      Company.find_or_create_by(slug: company_slug) do |company|
        company.name = company_name
      end
    end

    private

    attr_reader :company_name

    def company_slug
      @company_slug ||= company_name.parameterize
    end
  end
end
