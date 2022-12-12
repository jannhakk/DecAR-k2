//
//  WeatherCall.swift
//  DecAR
//
//  Created by iosdev on 6.12.2022.
//

import Foundation

struct WeatherCall: Decodable {
    let main: Weather
}
 struct WeatherCallWind: Decodable {
     let wind: Wind
 }

 struct Weather: Decodable {
     let temp: Double
     let humidity: Double
     let feels_like: Double
 }
 
struct WeatherCallDescription: Decodable {
        let weather: [MainInfo]
}

struct MainInfo: Decodable {
    let main: String
    let description: String
    let icon: String
    var weatherIconUrl: URL {
        let iconUrl = "http://openweathermap.org/img/wn/\(icon)@2x.png"
        return URL(string: iconUrl)!
    }
}

 struct Wind: Decodable {
     let speed: Double
 }

enum WeatherLoadState {
    case loading
    case success
    case failed
}

//ObservableObject for weather details that are used in weather view
class ViewModelWeather: ObservableObject {
    @Published private var weatherAllInfo: MainInfo?
    @Published private var weatherTemp: Weather?
    @Published private var weatherWind: Wind?
    @Published var message: String = ""
    @Published var weatherLoadState: WeatherLoadState = .loading
    
    var temperature: Double {
        guard let temp = weatherTemp?.temp else {
            return 0.0
        }
        return temp
    }

    var humidity: Double {
        guard let humid  = weatherTemp?.humidity else {
            return 0.0
        }
        return humid
    }

    var feelsLike: Double {
        guard let feelsLike = weatherTemp?.feels_like else {
            return 0.0
        }
        return feelsLike
    }

    var main: String {
        guard let mainInfo = weatherAllInfo?.main else {
            return ""
        }
        return mainInfo
    }

    var description: String {
        guard let description = weatherAllInfo?.description else {
            return ""
        }
        return description
    }

    var weatherIconurl: URL {
        guard let weatherIconUrl = weatherAllInfo?.weatherIconUrl else {
            return URL(string: "https://openweathermap.org/img/wn/10d@2x.png")!
        }
        return weatherIconUrl
    }
    
    var icon: String {
        guard let icon = weatherAllInfo?.icon else {
            return ""
        }
        return icon
    }
 

    var speed: Double {
        guard let speed = weatherWind?.speed else {
            return 0.0
        }
        return speed
    }
   
    func fetchWeather(city: String) {
        
        guard let city = city.escaped() else {
            DispatchQueue.main.async {
                self.message = "Not a city"
            }
            
            return
        }
        
        GetWeather().getWeatherDescription(city: city) { result in
            switch result {
            case .success(let description):
                DispatchQueue.main.async {
                    self.weatherAllInfo = description
                    self.weatherLoadState = .success
                }
            case .failure(_ ):
                print("error")
            }
        }
        
        GetWeather().getWeather(city: city) { result in
            switch result {
            case .success(let temperature):
                DispatchQueue.main.async {
                    self.weatherTemp = temperature
                    self.weatherLoadState = .success
                }
            case .failure(_ ):
                print("error")
            }
        }
        
        GetWeather().getWeatherWind(city: city) { result in
            switch result {
            case .success(let wind):
                DispatchQueue.main.async {
                    self.weatherWind = wind
                    self.weatherLoadState = .success
                }
            case .failure(_ ):
                print("error")
            }
        }
    }
}

extension String {
    
    func escaped() -> String? {
        return self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
    }
}
