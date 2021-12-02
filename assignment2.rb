require 'selenium-webdriver'

@driver = Selenium::WebDriver.for :chrome
@driver.manage.window.maximize
@driver.get("https://www.w3schools.com/html/html_tables.asp")


# below is to get number of columns
num_columns = @driver.find_elements(:css, '#customers tr th').count
puts "Number of columns: #{num_columns}"
# below is to get number of rows
num_rows = @driver.find_elements(:css, '#customers tr').count
puts "Number of rows: #{num_rows}"

# below method is to fetch entire row data based on column name and value
# return type: Hash
# Eg: get_row_by_col_value(column_name: 'Contact', value: 'Yoshi Tannamuri')
# result: {"Company"=>"Laughing Bacchus Winecellars", "Contact"=>"Yoshi Tannamuri", "Country"=>"Canada"}
 def get_row_by_col_value(column_name:, value: )
   table = @driver.find_element(:css, '#customers')
   headers = table.find_elements(:css, 'tr th').map{|i| i.text}
   data = []
   table.find_elements(:css, 'tr')[1..-1].each {|i| data << headers.zip(i.find_elements(:css, 'td').map(&:text)).to_h}
   data.find{|i| i[column_name] == value}
 end

 # Below is to get Contact and Company name for Country 'Austria'
 result = get_row_by_col_value(column_name: 'Country', value: 'Austria')
 puts "Expected row: #{result}"
 puts "Contact: #{result['Contact']}"
 puts "Company: #{result['Company']}"