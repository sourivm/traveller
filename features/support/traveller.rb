module Trip

#Traveller is a Human who is ready to travel
  class Traveller

    attr_accessor :temperature

    def initialize(temperature)
      @temperature = temperature
    end

    # Below method will return what type of -
    # clothing has been packed by the traveller
    # type of cloth will be decided by guidance file (support/guidance.yml)
    def cloth_type
      if temperature >= 20
        guidance_file['temperature']['greater than 19']['cloth']
      else
        guidance_file['temperature']['less than 20']['cloth']
      end
    end

    # Below method will return what type of weather
    # type of weather will be decided by guidance file (support/guidance.yml)
    def weather_type
      if temperature >= 20
        guidance_file['temperature']['greater than 19']['type']
      else
        guidance_file['temperature']['less than 20']['type']
      end
    end

    private

    def guidance_file
      YAML.load_file(File.join(Dir.pwd, 'features', 'support', 'guidance.yml'))
    end
  end
end