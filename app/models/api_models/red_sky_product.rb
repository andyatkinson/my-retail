module ApiModels
  class RedSkyProduct
    attr_reader :product_id, :name

    def initialize(product_id:, name:)
      @product_id = product_id
      @name = name
    end
  end
end
