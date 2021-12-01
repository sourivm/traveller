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
  Given traveller is advised on the weather
  When the temperature is less than 20 degree
  Then packed cloth type should be woollens

Scenario: Validate the cloth type when temperature is not cold
  Given traveller is advised on the weather
  When the temperature is greater than 20 degree
  Then packed cloth type should be swimmers
