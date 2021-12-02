module Trip

#Traveller is a Human who is ready to travel
  class Traveller

    attr_accessor :cloth

    def initialize(cloth)
      @cloth = cloth
    end

    # Below method will return what type of -
    # clothing has been packed by the traveller
    # type of cloth will be decided by guidance file (support/guidance.yml)
    def cloth_type
      if cloth.is_a?(String)
        cloth
      else
        cloth.join(' and ')
      end
    end
  end
end