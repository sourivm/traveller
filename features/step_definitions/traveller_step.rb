
Given('Current day falls under weekdays') do
  days = {"Monday" => 5, "Tuesday" => 4, "Wednesday" => 3, "Thursday" => 2, "Friday" => 1}
  current_day = Date.today.strftime('%A')
  logger.info "Current day: #{current_day}"
  days_count = days.select{|i,j| i == current_day }.values.first
  unless days_count
  	logger.warn "Current day is #{current_day},  it is not considerd as weekdays"
  	skip_this_scenario
  end
end

Given('I get temperature for the current work week') do
  @temperature = 10
end

When(/^the temperature is (.*) degree$/) do |temp_condition|
  guidance_file = YAML.load_file(File.join(Dir.pwd, 'features', 'support', 'guidance.yml'))['temperature']
  if temp_condition.include?('greater than') && @temperature >= 20
    @expected_type = guidance_file['greater than 19']['type']
    @expected_cloth = guidance_file['greater than 19']['cloth']
  elsif temp_condition.include?('less than') && @temperature <= 19
    @expected_type = guidance_file['less than 20']['type']
    @expected_cloth = guidance_file['less than 20']['cloth']
  else
  	logger.info "Temperature: #{@temperature} which is not #{temp_condition}, so skipping this scenario..."
  	skip_this_scenario
  end
  logger.info "Temperature is #{@temperature} which is #{temp_condition}"
  logger.info "Expected cloth: #{@expected_cloth}"
  logger.info "Expected type: #{@expected_type}"
end

Then(/^weather is considered as (.*)$/) do |weather_type|
  raise "Weather is not considered as #{weather_type}" unless weather_type.include?(@expected_type)
end

Given('traveller is advised on the weather') do
  @traveller = Trip::Traveller.new(@temperature)
  logger.info "Traveller is advised to pick #{@expected_cloth}"
end

Then(/^packed cloth type should be (woollens|swimmers)$/) do |cloth_type|
  raise "Traveller is not picked #{cloth_type} cloth" unless @traveller.cloth_type == cloth_type
end

