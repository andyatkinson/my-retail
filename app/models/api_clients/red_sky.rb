module ApiClients
  class RedSky
    BASE_URL = 'http://redsky.target.com/v2/pdp/tcin/'.freeze

    def self.get_product_details(product_id:)
      # NOTE: could make the excluded items configurable
      excluded_items = 'taxonomy,price,promotion,bulk_ship,rating_and_review_reviews,rating_and_review_statistics,question_answer_statistics'.freeze
      url = "#{BASE_URL}#{product_id}?excludes=#{excluded_items}"
      log("product_id=#{product_id} url=#{url}")

      begin
        response = JSON.parse(RestClient.get(url))
        response['product']['item']['product_description']['title']
      rescue Exception => e
        log("exception message=#{e.message}")
      end
    end

    # Main entry point
    # Example:
    # `ApiClients::RedSky.build_red_sky_product(product_id: 13860428)`
    #
    # e.g. product_id: 13860428
    def self.build_red_sky_product(product_id:)
      name = get_product_details(product_id: product_id)
      if name
        ApiModels::RedSkyProduct.new(
          name: name
        )
      else
        log("exception product_id=#{product_id} issue=name_not_found")
      end
    end

    private
    def self.log(message)
      # NOTE: could add additional logging levels
      Rails.logger.debug "api_clients_red_sky #{message}"
    end
  end
end
