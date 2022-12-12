
![DecAR Logo](https://i.imgur.com/tTV1oJo.png)
# DecAR

DecAR is an augmented reality interior design application aimed for individuals
and companies alike. DecAR works to tackle the problem of manual
labour and its costs during the interior design phase, and allows you to visualize
 what your dream apartment will look like without the trouble, using AR.

This is a fork of DecAR core software repository: https://github.com/IlmHe/DecAR-csw




## Run Locally

Clone the project

```bash
  git clone https://github.com/jannhakk/DecAR-k2.git
```
- Open the project in [Xcode](https://apps.apple.com/us/app/xcode/id497799835?mt=12)
- All other features except AR View work on a simulator, For AR View you will need an iPhone configured in developer mode. Further info [here](https://developer.apple.com/documentation/xcode/running-your-app-in-simulator-or-on-a-device)
- Weather page needs an API key to work, get one for free [here](https://openweathermap.org/API)
- Navigate to Views > Weather.swift and add your API key to apiKey variable
```
 34  @State private var apiKey = "API key here"
```

## Features

- AR View for placing and saving 3D models
- Map with custom listing locations and user location
- Weather page, with chuck norris jokes



## Tech Stack

**Languages**: Swift, Objective-C

**UI frameworks**: SwiftUI, UIKit

**Augmented reality frameworks**: ARKit, RealityKit, SceneKit

**Testing frameworks**: XCTest

**Other frameworks**: MapKit, Core Data

**APIs**: [OpenWeatherMap](https://openweathermap.org/api), [chucknorris.io](https://api.chucknorris.io/)


## Screenshots
#### **AR View**
![Ar view](https://i.imgur.com/CcWxEgw.png)

#### **Weather View**
![Weather view](https://i.imgur.com/Kh67JRo.png)

#### **Navigation menu in AR View**
![Navigation menu in AR View](https://i.imgur.com/RgawjG8.png)

#### **Furniture menu**
![Furniture menu](https://i.imgur.com/ybwG26S.png)


## Authors

- [@IlmHe](https://github.com/IlmHe)
- [@jannhakk](https://github.com/jannhakk)
- [@remysi](https://github.com/remysi)

