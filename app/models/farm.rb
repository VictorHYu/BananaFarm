class Farm < ApplicationRecord
	has_many:bananas
	accepts_nested_attributes_for :bananas
    
    after_initialize do |farm|
        #update weather status if farm has not been updated in 6 hours
        elapsed_hours = ((Time.now - farm.weather_last_updated) / 3600).to_i

        begin
            if elapsed_hours >= 6
                url = 'http://api.openweathermap.org/data/2.5/weather?id=6167865' + '&APPID=' + Rails.application.secrets.weather_api_key
                response = HTTParty.get(url)
                
                farm.weather_temperature = (response['main']['temp'] - 273.15).to_i
                farm.weather_main = response['weather'][0]['main']
                farm.weather_icon = response['weather'][0]['icon']
                farm.weather_last_updated = DateTime.now
                farm.save
            end
        rescue => e
            puts e.message
            farm.weather_temperature = 999
            farm.weather_main = 'none'
            farm.weather_icon = '01d.png'
            farm.weather_last_updated = DateTime.now
            farm.save
        end
    end
end
