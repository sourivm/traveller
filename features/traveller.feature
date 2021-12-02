Feature: A traveller is to pack appropriate cloth for an upcoming business trip

Background: 
  Given Current day falls under weekdays
  And I get temperature for the current work week

Scenario: Validate the weather when it is cold
  When the temperature is less than 20 degree
  Then weather is considered as cold

Scenario: Validate the weather when it is not cold
  When the temperature is greater than 20 degree
  Then weather is considered as not cold

Scenario: Validate the cloth type when temperature is cold
  Given the temperature is less than 20 degree
  When traveller is advised on the weather
  Then packed cloth type should be woollens

Scenario: Validate the cloth type when temperature is not cold
  Given the temperature is greater than 20 degree
  When traveller is advised on the weather
  Then packed cloth type should be swimmers

Scenario: Validate the cloth type when upcoming days temperature are both cold and not cold
  Given the temperature are both cold and not cold
  When traveller is advised on the weather
  Then packed cloth type should be woollens and swimmers

