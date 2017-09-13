module FarmsHelper
    def getWeatherString(weather)
        case (weather)
        when 'none'
            return "Unable to retrieve weather data at this time."
        else
            return weather
        end
    end
    
    def getWeatherIcon(iconName)
        return 'http://openweathermap.org/img/w/' + iconName[0..1] + 'd.png';
    end
end
