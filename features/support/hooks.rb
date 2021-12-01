Before do |scenario|
  logger.info "Started scenario: #{scenario.name}"
end

After do |scenario|
  logger.info "End scenario: #{scenario.name}"
  logger.info '%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%'
end