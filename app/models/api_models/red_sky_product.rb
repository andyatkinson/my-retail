module ApiModels
  class RedSkyProduct
    attr_reader :name

    def initialize(name:)
      @name = name
    end
  end
end
