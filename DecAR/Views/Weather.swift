//
//  Weather.swift
//  DecAR
//
//  Created by iosdev on 6.12.2022.
//

import Foundation
import CoreLocation
import SwiftUI
import Combine

let weatherSearch = NSLocalizedString("weatherSearch", comment: "weatherSearch")
let weatherFetchJoke = NSLocalizedString("weatherFetchJoke", comment: "weatherFetchJoke")
let language = NSLocalizedString("weatherLanguage", comment: "weatherLanguage")
let currentWeather = NSLocalizedString("currentWeather", comment: "currentWeather")
let Temperature = NSLocalizedString("Temperature", comment: "Temperature")
let feelsLike = NSLocalizedString("feelsLike", comment: "feelsLike")
let Humidity = NSLocalizedString("Humidity", comment: "Humidity")
let windSpeed = NSLocalizedString("windSpeed", comment: "windSpeed")
let Description = NSLocalizedString("Description", comment: "Description")
let Main = NSLocalizedString("Main", comment: "Main")



enum NetwokrError: Error {
    case decodingError
    case badUrl
    case somethingWentWrong
}

//Handles openweather API call and JSON decoding
class GetWeather {
    
    @State private var apiKey = "10fa652305f6b2fc849c3ac9acdc7e50"
    
    func urlWeather(_ city: String) -> URL? {
        guard let url = URL(string:
                                "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=\(apiKey)&units=metric&lang=\(language)"
        ) else {
            return nil
        }
        return url
    }
    
    func getWeather(city: String, completion: @escaping (Result<Weather?, NetwokrError>) -> Void) {
        
        guard let url = urlWeather(city) else {
            return completion(.failure(.badUrl))
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data, error == nil else {
                return completion(.failure(.somethingWentWrong))
            }
            
            let weatherResponse = try? JSONDecoder().decode(WeatherCall.self, from: data)
            if let weatherResponse = weatherResponse {
                completion(.success(weatherResponse.main))
            } else {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
    
    func getWeatherDescription(city: String, completion: @escaping (Result<MainInfo?, NetwokrError>) -> Void) {
     
     guard let url = urlWeather(city) else {
     return completion(.failure(.badUrl))
     }
     
     URLSession.shared.dataTask(with: url) { data, response, error in
     
     guard let data = data, error == nil else {
     return completion(.failure(.somethingWentWrong))
     }
     
         let weatherResponse = try? JSONDecoder().decode(WeatherCallDescription.self, from: data)
     if let weatherResponse = weatherResponse {
         completion(.success(weatherResponse.weather[0]))
         print("main info \(weatherResponse.weather)")
     } else {
     completion(.failure(.decodingError))
     }
     }.resume()
     }
     
    func getWeatherWind(city: String, completion: @escaping (Result<Wind?, NetwokrError>) -> Void) {
        
        guard let url = urlWeather(city) else {
            return completion(.failure(.badUrl))
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data, error == nil else {
                return completion(.failure(.somethingWentWrong))
            }
            
            let weatherResponse = try? JSONDecoder().decode(WeatherCallWind.self, from: data)
            if let weatherResponse = weatherResponse {
                completion(.success(weatherResponse.wind))
                print("main info \(weatherResponse.wind)")

            } else {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
}

//In weather view user can search current weather for a city. View also has a button that fetches random Chuck Norris joke.
struct WeatherView: View {
    
    @ObservedObject private var weatherInfo = ViewModelWeather()
    @State private var joke: String = ""
    @State private var city: String = ""
    var url = URL(string: "https://openweathermap.org/img/wn/10d@2x.png")

       var body: some View {
           
           VStack {
               Text(currentWeather)
                   .font(.title)
                   .padding(.horizontal)
               HStack {
                   TextField(weatherSearch, text: self.$city,
                             onEditingChanged: { _ in }, onCommit: {
                       
                       self.weatherInfo.fetchWeather(city: self.city)
                   }).textFieldStyle(RoundedBorderTextFieldStyle())
                       .padding(5)
                   Button {
                       self.weatherInfo.fetchWeather(city: self.city)
                   } label: {
                       Image(systemName: "magnifyingglass.circle.fill")
                           .font(.title3)
                           .padding(5)
                   }
               }
               Spacer()
               HStack{
                   AsyncImage(url: URL(string: "https://openweathermap.org/img/wn/\(self.weatherInfo.icon)@2x.png")) { phase in
                       switch phase {
                       case .empty:
                           ProgressView()
                               .progressViewStyle(.circular)
                       case .success(let image):
                           image.resizable()
                               .aspectRatio(contentMode: .fit)
                       default: Color.clear // <-- here
                       }
                   }
                   .frame(maxWidth: 150, maxHeight: 150)
                   .padding()
                       .overlay(
                           RoundedRectangle(cornerRadius: 16)
                               .stroke(.blue, lineWidth: 4)
                       )
                       Group {
                           VStack {
                           Text("\(self.weatherInfo.temperature, specifier: "%.1f") ℃")
                                   .font(.largeTitle)
                               Text(Temperature)                                .accessibilityLabel(Temperature)

                       }
                       }
                       .padding()
                           .overlay(
                               RoundedRectangle(cornerRadius: 16)
                                   .stroke(.blue, lineWidth: 4)
                           )
                    
               }
               Spacer()
               Group {
                   VStack(alignment: .leading, spacing: 2) {
                           Text("\(feelsLike) \(self.weatherInfo.feelsLike , specifier: "%.1f") ℃")
                               .font(.title2)
                               .padding()
                               .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(.blue, lineWidth: 2)
                               )
                               .accessibilityLabel(feelsLike)
                           Text("\(Humidity) \(self.weatherInfo.humidity, specifier: "%.1f") %")
                               .font(.title2)
                               .padding()
                               .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(.blue, lineWidth: 2)
                               )
                               .accessibilityLabel(Humidity)
                           Text("\(windSpeed) \(self.weatherInfo.speed , specifier: "%.1f") m/s")
                               .font(.title2)
                               .padding()
                               .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(.blue, lineWidth: 2)
                               )
                               
                               .accessibilityLabel(windSpeed)
                   }
               }
               
           }
            Spacer()
           Text(joke)
               .padding(10)
               .font(.title3)
               .accessibilityLabel(joke)
               .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(.blue, lineWidth: 1)
               )
           Button("\(weatherFetchJoke)") {
               Task {
                   let (data, _) = try await URLSession.shared.data(from: URL(string:"https://api.chucknorris.io/jokes/random")!)
                   let decodedResponse = try? JSONDecoder().decode(Joke.self, from: data)
                   joke = decodedResponse?.value ?? ""
               }
           }
                   .accessibilityLabel(weatherFetchJoke)
                   .padding()
                   .background(Color.gray.opacity(0.2))
                   .clipShape(Capsule())
           Spacer()
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView()
    }
}

struct Joke: Codable {
    let value: String
}
