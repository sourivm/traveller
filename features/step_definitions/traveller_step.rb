
Given('Current day falls under weekdays') do
  days = {"Monday" => 5, "Tuesday" => 4, "Wednesday" => 3, "Thursday" => 2, "Friday" => 1}
  current_day = Date.today.strftime('%A')
  logger.info "Current day: #{current_day}"
  days_count = days.select{|i,j| i == current_day }.values.first
  unless days_count
  	logger.warn "Current day is #{current_day},  it is not considerd as weekdays"
  	skip_this_scenario
  end
  logger.info "Remaining days in this current week #{days.keys[days_count+1..-1]}"
  @remaining_days_in_week = days_count
end

Given('I get temperature for the current work week') do
  api_yml = YAML.load_file(File.join(Dir.pwd, 'features', 'support', 'openweathermap.yml'))
  request_url = "#{api_yml['host']+api_yml['endpoint']}q=London&cnt=#{@remaining_days_in_week}&appid=#{api_yml['api_key']}"
  response = RestClient.get(request_url)
  # Raising exception if request_url has some issues
  raise "Couldn't fetch Temperature details from #{api_yml['host']}" unless response.code == 200
  a = JSON.parse(response.body)
  temp = a['list'].map{|x| x['main']}.map{|k| k['temp']}
  celsius = temp.map {|i| (i - 273.15).round(2)} # converting Kelvin to celcius
  logger.info "Temperature of remaining weekdays #{celsius}"
  @temperature = celsius
end

When(/^the temperature is (.*) degree$/) do |temp_condition|
  guidance_file = YAML.load_file(File.join(Dir.pwd, 'features', 'support', 'guidance.yml'))['temperature']
  if temp_condition.include?('greater than') && @temperature.all?{|l| l >= 20 }
    @expected_type = guidance_file['greater than 19']['type']
    @expected_cloth = guidance_file['greater than 19']['cloth']
  elsif temp_condition.include?('less than') && @temperature.all?{|l| l < 20 }
    @expected_type = guidance_file['less than 20']['type']
    @expected_cloth = guidance_file['less than 20']['cloth']
  else
  	logger.info "Temperature: #{@temperature} which is(are) not #{temp_condition}, so skipping this scenario..."
  	skip_this_scenario
  end
  logger.info "Temperature is(are) #{@temperature} which is #{temp_condition}"
  logger.info "Expected cloth: #{@expected_cloth}"
  logger.info "Expected type: #{@expected_type}"
end

Then(/^weather is considered as (.*)$/) do |weather_type|
  raise "Weather is not considered as #{weather_type}" unless weather_type.include?(@expected_type)
end

Given('traveller is advised on the weather') do
  @traveller = Trip::Traveller.new(@expected_cloth)
  logger.info "Traveller is advised to pick #{@expected_cloth}"
end

When('the temperature are both cold and not cold') do
  guidance_file = YAML.load_file(File.join(Dir.pwd, 'features', 'support', 'guidance.yml'))['temperature']
  if @temperature.any?{|l| l >= 20 } && @temperature.any?{|l| l < 20 }
    @expected_cloth = guidance_file['less than 20']['cloth'], guidance_file['greater than 19']['cloth']
  else
    logger.info "Temperature are not cold and Hot, so skipping this scenario..."
    skip_this_scenario
  end
end

Then(/^packed cloth type should be (woollens|swimmers|woollens and swimmers)$/) do |expected_cloth_type|
  logger.info "Traveller is picked #{@traveller.cloth_type}"
  raise "Traveller is not picked #{expected_cloth_type} cloth" unless @traveller.cloth_type == expected_cloth_type
end

