//
//  ContentView.swift
//  Weather
//
//  Created by Daniel on 26/7/2025.
//
//Height List
//大：280
//中：210
//小：210
import SwiftUI

struct ContentView: View {
    @StateObject private var locationManager = LocationManager()
    
    let calendar = Calendar.current
    var hour: Int {
        calendar.component(.hour, from: Date())
    }
    var second: Int {
        calendar.component(.second, from: Date())
    }
    
    @State private var timer: Timer?
    @State private var UpdateWeatherTimer: Timer?
    
    @State private var icon_name : String?
    
    @State private var DevMode : Bool = false
    
    @State private var temp : Double?
    @State private var maxTemp : Double?
    @State private var minTemp : Double?
    @State private var feelsLike : Double?
    @State private var description : String?
    @State private var humidity : Int?
    @State private var visibility : Double?
    @State private var visibility_km : Double?
    @State private var windSpeed : Double?
    @State private var windDeg : Int?
    @State private var windGust : Double?
    @State private var pressure : Int?
    @State private var seaLevel : Int?
    @State private var grndLevel : Int?
    
    @State private var cityName : String?
    
    var body: some View {
        ScrollView{
            VStack {
                if let location = locationManager.location{
                    VStack{
                        
                        VStack{
                            if DevMode{
                                Text("纬度: \(location.coordinate.latitude)")
                                Text("经度: \(location.coordinate.longitude)")
                                Text("海拔: \(location.altitude) 米")
                                Text("精度: \(location.horizontalAccuracy) 米")
                            }
                            
                            
                            Text("我的位置")
                                .padding(.top)
                            
                            Text(cityName ?? "----")
                                .font(.largeTitle)
                            
                            Text(temp != nil ? String(temp!)+"°" : "--")
                                .font(.system(size: 80))
                                .fontWeight(.light)
                            
                            HStack{
                                
                                HStack{
                                    VStack(spacing: -5){
                                        Text("最")
                                        Text("高")
                                    }.font(.title2)
                                    
                                    Text(maxTemp != nil ? String(maxTemp!)+"°" : "--")
                                        .font(.system(size: 40))
                                        .fontWeight(.light)
                                }
                                
                                
                                
                                HStack{
                                    VStack(spacing: -5){
                                        Text("最")
                                        Text("低")
                                    }.font(.title2)
                                    
                                    Text(minTemp != nil ? String(minTemp!)+"°" : "--")
                                        .font(.system(size: 40))
                                        .fontWeight(.light)
                                }
                                
                            }
                            
                            Text("體感溫度 \(feelsLike != nil ? String(feelsLike!)+"°" : "--")")
                                .padding(.top,2)
                                .font(.title2)
                        }.padding()
                        
                        VStack{
                            VStack{
                                Spacer()
                                Text("現時")
                                    .bold()
                                
                                HStack{
                                    Text(description ?? "--")
                                        .font(.title)
                                    AsyncImage(url: URL(string: "https://openweathermap.org/img/wn/\(icon_name ?? "")@2x.png")) { Image in
                                        Image
                                            .resizable()
                                            .scaledToFit()
                                            .scaleEffect(1.5)
                                            .frame(width: 45, height: 45)
                                    } placeholder: {
                                        ProgressView()
                                            .tint(.white)
                                            .controlSize(.large)
                                            .onTapGesture{
                                                print("https://openweathermap.org/img/wn/\(String(describing: icon_name))@2x.png")
                                            }
                                            .frame(width: 45, height: 45)
                                    }
                                }
                                
                                
                                Text("濕度")
                                    .font(.title3)
                                    .bold()
                                
                                Text(humidity != nil ? String(humidity!)+"%" : "--")
                                    .font(.title)
                                    .frame(height: 45)
                                
                                Text(temp != nil ? String(temp!)+"°" : "--")
                                    .bold()
                                
                                Spacer()
                            }
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 210)
                            .padding(.horizontal)
                            .background(Color( 7...17 ~= hour ? Color.black : Color.white).opacity(0.1))
                            .cornerRadius(20)
                            .padding(.vertical)
                            
                            HStack{
                                VStack{
                                    
                                    HStack{
                                        Label {
                                            Text("濕度")
                                        } icon: {
                                            Image(systemName: "humidity.fill")
                                        }.padding()
                                        
                                        Spacer()
                                    }
                                    
                                    Spacer()

                                    humidityGauge
                                        .scaleEffect(2.0)
                                    
                                    Spacer()
                                }
                                .frame(maxWidth: .infinity)
                                .frame(height: 210)
                                .background(Color( 7...17 ~= hour ? Color.black : Color.white).opacity(0.1))
                                .cornerRadius(20)
                                
                                VStack{
                                    HStack{
                                        Label {
                                            Text("氣壓")
                                        } icon: {
                                            Image(systemName: "gauge.with.dots.needle.bottom.50percent")
                                        }
                                        .padding(.horizontal)
                                        .padding(.top)
                                        
                                        Spacer()
                                    }
                                    
                                    VStack{
                                        HStack{
                                            Text("氣壓")
                                                .bold()
                                                .font(.title2)
                                                .padding(.horizontal)
                                            Spacer()
                                        }
                                        HStack{
                                            Text(pressure != nil ? String(pressure!)+"百帕" : "--")
                                                .padding(.horizontal)
                                            Spacer()
                                        }.padding(.horizontal)
                                    }
                                    
                                    VStack{
                                        HStack{
                                            Text("海平面氣壓")
                                                .bold()
                                                .font(.title2)
                                                .padding(.horizontal)
                                            Spacer()
                                        }
                                        HStack{
                                            Text(seaLevel != nil ? String(seaLevel!)+"百帕" : "--")
                                                .padding(.horizontal)
                                            Spacer()
                                        }.padding(.horizontal)
                                    }
                                    
                                    Spacer()
                                    HStack{
                                        Text("地面氣壓")
                                            .bold()
                                            .font(.title2)
                                            .padding(.horizontal)
                                        Spacer()
                                    }
                                    HStack{
                                        Text(grndLevel != nil ? String(grndLevel!)+"百帕" : "--")
                                            .padding(.horizontal)
                                        Spacer()
                                    }.padding(.horizontal)
                                    Spacer()
                                }
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .frame(height: 210)
                                .background(Color( 7...17 ~= hour ? Color.black : Color.white).opacity(0.1))
                                .cornerRadius(20)
                            }
                            
                            
                            VStack{
                                Spacer()
                                HStack{
                                    Label {
                                        Text("風")
                                            .bold()
                                    } icon: {
                                        Image(systemName: "wind")
                                    }.padding()
                                    
                                    Spacer()
                                }
                                VStack{
                                    HStack{
                                        Text("風速")
                                            .font(.title3)
                                            .bold()
                                        
                                        Spacer()
                                        
                                        Text(windSpeed != nil ? "\(windSpeed!.formatted())米/秒" : "--")
                                            .font(.title)
                                            .frame(height: 45)
                                    }
                                    HStack{
                                        Text("風向")
                                            .font(.title3)
                                            .bold()
                                        
                                        Spacer()
                                        
                                        Text(windDeg != nil ? "\(DegreeAndDirection.findDirection(for: windDeg!)) \(windDeg!)°" : "--")
                                            .font(.title)
                                            .frame(height: 45)
                                    }
                                    
                                    HStack{
                                        Text("陣風速度")
                                            .font(.title3)
                                            .bold()
                                        
                                        Spacer()
                                        
                                        Text(windGust != nil ? "\(windGust!.formatted())米/秒" : "--")
                                            .font(.title)
                                            .frame(height: 45)
                                    }
                                    Spacer()
                                }.padding(.horizontal)
                            }
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 210)
                            .background(Color( 7...17 ~= hour ? Color.black : Color.white).opacity(0.1))
                            .cornerRadius(20)
                            .padding(.vertical)
                            
                            VStack{
                                Group{
                                    Spacer()
                                    
                                    HStack{
                                        Label {
                                            Text("航海氣象")
                                                .bold()
                                        } icon: {
                                            Image(systemName: "sailboat")
                                        }
                                        Spacer()
                                    }.padding()
                                    
                                    VStack{
                                        HStack{
                                            Text("能見度")
                                                .font(.title3)
                                                .bold()
                                            
                                            Spacer()
                                            
                                            if visibility ?? 0 < 1000{
                                                Text(visibility != nil ? "\(visibility!.formatted())米" : "--")
                                                    .font(.title)
                                                    .frame(height: 45)
                                            }else{
                                                Text(visibility_km != nil ? "\(visibility_km!.formatted())公里" : "--")
                                                    .font(.title)
                                                    .frame(height: 45)
                                            }
                                        }
                                        
                                        HStack{
                                            Text("風速")
                                                .font(.title3)
                                                .bold()
                                            
                                            Spacer()
                                            
                                            Text(windSpeed != nil ? "\(windSpeed!.formatted())米/秒" : "--")
                                                .font(.title)
                                                .frame(height: 45)
                                        }
                                        
                                        HStack{
                                            Text("風向")
                                                .font(.title3)
                                                .bold()
                                            
                                            Spacer()
                                            
                                            Text(windDeg != nil ? "\(DegreeAndDirection.findDirection(for: windDeg!)) \(windDeg!)°" : "--")
                                                .font(.title)
                                                .frame(height: 45)
                                        }
                                        
                                        HStack{
                                            Text("陣風速度")
                                                .font(.title3)
                                                .bold()
                                            
                                            Spacer()
                                            
                                            Text(windGust != nil ? "\(windGust!.formatted())米/秒" : "--")
                                                .font(.title)
                                                .frame(height: 45)
                                        }
                                    }.padding(.horizontal)
                                    
                                    Spacer()
                                    
                                }
                            }
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 280)
                            //.padding(.horizontal)
                            .background(Color( 7...17 ~= hour ? Color.black : Color.white).opacity(0.1))
                            .cornerRadius(20)
                            //.padding(.vertical)
                            
                        }.padding(.horizontal)
                        
                        Spacer()
                    }.onAppear{
                        locationManager.requestPermission()
                        
                        
                        Task {
                            let StringData = await fetchData(apiURL: "https://api.openweathermap.org/data/2.5/weather?lat=\(locationManager.location!.coordinate.latitude)&lon=\(locationManager.location!.coordinate.longitude)&appid=f81f84e6f9b697a9eff59fabc479e701&lang=zh_tw&units=metric")
                            
                            print(StringData)
                            
                            
                            if let jsonData = StringData.data(using: .utf8) {
                                do {
                                    let Welcome = try JSONDecoder().decode(Welcome.self, from: jsonData)
                                    //print(Welcome.main.temp)
                                    temp = Welcome.main.temp
                                    minTemp = Welcome.main.tempMin
                                    maxTemp = Welcome.main.tempMax
                                    icon_name = Welcome.weather.first!.icon
                                    description = Welcome.weather.first!.description
                                    feelsLike = Welcome.main.feelsLike
                                    humidity = Welcome.main.humidity
                                    visibility = Welcome.visibility
                                    visibility_km = Welcome.visibility * 0.001
                                    windSpeed = Welcome.wind.speed
                                    windDeg = Welcome.wind.deg
                                    windGust = Welcome.wind.gust
                                    seaLevel = Welcome.main.seaLevel
                                    grndLevel = Welcome.main.grndLevel
                                    pressure = Welcome.main.pressure
                                } catch {
                                    // 处理解码错误
                                    print("解码失败: \(error.localizedDescription)")
                                    print("错误详情: \(error)")
                                }
                            } else {
                                // 处理字符串转数据失败的情况
                                print("无法将字符串转换为数据")
                            }
                            
                            
                            //print(Main)
                        }
                        getCity(lat: locationManager.location?.coordinate.latitude ?? 0, lon: locationManager.location?.coordinate.longitude ?? 0) { result in
                            switch result {
                            case .success(let city):
                                print("对应的城市: \(city)")  // 输出: 北京市
                                cityName = city
                            case .failure(let error):
                                print("错误: \(error.localizedDescription)")
                            }
                        }
                        
                        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [self] _ in
                            locationManager.requestPermission()
                        }
                        
                        UpdateWeatherTimer = Timer.scheduledTimer(withTimeInterval: 60, repeats: true) { [self] _ in
                            Task {
                                let StringData = await fetchData(apiURL: "https://api.openweathermap.org/data/2.5/weather?lat=\(locationManager.location!.coordinate.latitude)&lon=\(locationManager.location!.coordinate.longitude)&appid=f81f84e6f9b697a9eff59fabc479e701&lang=zh_tw&units=metric")
                                
                                print(StringData)
                                
                                
                                if let jsonData = StringData.data(using: .utf8) {
                                    do {
                                        let Welcome = try JSONDecoder().decode(Welcome.self, from: jsonData)
                                        //print(Welcome.main.temp)
                                        temp = Welcome.main.temp
                                        minTemp = Welcome.main.tempMin
                                        maxTemp = Welcome.main.tempMax
                                        icon_name = Welcome.weather.first!.icon
                                        description = Welcome.weather.first!.description
                                        feelsLike = Welcome.main.feelsLike
                                        humidity = Welcome.main.humidity
                                        visibility = Welcome.visibility
                                        visibility_km = Welcome.visibility * 0.001
                                        windSpeed = Welcome.wind.speed
                                        windDeg = Welcome.wind.deg
                                        windGust = Welcome.wind.gust
                                        seaLevel = Welcome.main.seaLevel
                                        grndLevel = Welcome.main.grndLevel
                                        pressure = Welcome.main.pressure
                                    } catch {
                                        // 处理解码错误
                                        print("解码失败: \(error.localizedDescription)")
                                        print("错误详情: \(error)")
                                    }
                                } else {
                                    // 处理字符串转数据失败的情况
                                    print("无法将字符串转换为数据")
                                }
                                
                                
                                //print(Main)
                            }
                        }
                        RunLoop.current.add(timer!, forMode: .common)
                        
                        RunLoop.current.add(UpdateWeatherTimer!, forMode: .common)
                        
                        
                    }
                    .onDisappear {
                        timer?.invalidate()
                        UpdateWeatherTimer?.invalidate()
                    }
                    
                } else if let error = locationManager.errorMessage , error != "失敗: 請到設定同意獲取位置" , error != "獲取位置失敗: The operation couldn’t be completed. (kCLErrorDomain error 1.)" {
                    Spacer()
                    
                    Image(systemName: "location.slash.fill")
                        .font(.system(size: 200))
                        .foregroundColor(.accentColor)
                    
                    Spacer()
                    
                    Text("錯誤")
                        .font(.largeTitle)
                        .bold()
                        .padding()
                    
                    Text("暫時無法定位")
                        .font(.title)
                        .bold()
                        .padding()
                    
                    Text(error)
                        .multilineTextAlignment(.center)
                        .font(.title3)
                        .padding()
                }else {
                    Spacer()
                    
                    Image(systemName: "location.slash.fill")
                        .font(.system(size: 200))
                        .foregroundColor(.accentColor)
                    
                    Spacer()
                    
                    Text("錯誤")
                        .font(.largeTitle)
                        .bold()
                        .padding()
                    
                    Text("請到設置打開定位功能")
                        .font(.title)
                        .bold()
                        .padding(.vertical)
                    
                    
                    Link(destination: URL(string: UIApplication.openSettingsURLString)!) {
                        Label {
                            Text("立即前往本應用的設置")
                        } icon: {
                            Image(systemName: "gear")
                        }.font(.title2)
                    }
                    .buttonStyle(.borderedProminent)
                    .buttonBorderShape(.capsule)
                    
                    Text("點擊「立即前往本應用的設置」按鈕後\n請按「位置」> 「使用App時」\n然後重新打開該應用\n即可使用")
                        .font(.title3)
                        .bold()
                        .padding(.vertical)
                        .multilineTextAlignment(.center)
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background{
            LinearGradient(
                gradient: Gradient(colors: [
                    7...17 ~= hour ? Color.white : Color.black,
                    7...17 ~= hour ? Color.blue : Color(red:0/255,green:51/255,blue:102/255)
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
        }
        .foregroundColor(7...17 ~= hour ? Color.black : Color.white)
        .onChange(of: locationManager.location?.coordinate.latitude, { oldValue, newValue in
            Task {
                let StringData = await fetchData(apiURL: "https://api.openweathermap.org/data/2.5/weather?lat=\(locationManager.location!.coordinate.latitude)&lon=\(locationManager.location!.coordinate.longitude)&appid=f81f84e6f9b697a9eff59fabc479e701&lang=zh_tw&units=metric")
                
                print(StringData)
                
                
                if let jsonData = StringData.data(using: .utf8) {
                    do {
                        let Welcome = try JSONDecoder().decode(Welcome.self, from: jsonData)
                        //print(Welcome.main.temp)
                        temp = Welcome.main.temp
                        minTemp = Welcome.main.tempMin
                        maxTemp = Welcome.main.tempMax
                        icon_name = Welcome.weather.first!.icon
                        description = Welcome.weather.first!.description
                        feelsLike = Welcome.main.feelsLike
                        humidity = Welcome.main.humidity
                        visibility = Welcome.visibility
                        visibility_km = Welcome.visibility * 0.001
                        windSpeed = Welcome.wind.speed
                        windDeg = Welcome.wind.deg
                        windGust = Welcome.wind.gust
                        seaLevel = Welcome.main.seaLevel
                        grndLevel = Welcome.main.grndLevel
                        pressure = Welcome.main.pressure
                    } catch {
                        // 处理解码错误
                        print("解码失败: \(error.localizedDescription)")
                        print("错误详情: \(error)")
                    }
                } else {
                    // 处理字符串转数据失败的情况
                    print("无法将字符串转换为数据")
                }
                
                
                //print(Main)
            }
            getCity(lat: locationManager.location!.coordinate.latitude, lon: locationManager.location!.coordinate.longitude) { result in
                switch result {
                case .success(let city):
                    print("对应的城市: \(city)")  // 输出: 北京市
                    cityName = city
                case .failure(let error):
                    print("错误: \(error.localizedDescription)")
                }
            }
        })
        .onChange(of: locationManager.location?.coordinate.longitude, { oldValue, newValue in
            Task {
                let StringData = await fetchData(apiURL: "https://api.openweathermap.org/data/2.5/weather?lat=\(locationManager.location!.coordinate.latitude)&lon=\(locationManager.location!.coordinate.longitude)&appid=f81f84e6f9b697a9eff59fabc479e701&lang=zh_tw&units=metric")
                
                print(StringData)
                print("https://api.openweathermap.org/data/2.5/weather?lat=\(locationManager.location!.coordinate.latitude)&lon=\(locationManager.location!.coordinate.longitude)&appid=f81f84e6f9b697a9eff59fabc479e701&lang=zh_tw&units=metric")
                
                
                if let jsonData = StringData.data(using: .utf8) {
                    do {
                        let Welcome = try JSONDecoder().decode(Welcome.self, from: jsonData)
                        //print(Welcome.main.temp)
                        temp = Welcome.main.temp
                        minTemp = Welcome.main.tempMin
                        maxTemp = Welcome.main.tempMax
                        icon_name = Welcome.weather.first!.icon
                        description = Welcome.weather.first!.description
                        feelsLike = Welcome.main.feelsLike
                        humidity = Welcome.main.humidity
                        visibility = Welcome.visibility
                        visibility_km = Welcome.visibility * 0.001
                        windSpeed = Welcome.wind.speed
                        windDeg = Welcome.wind.deg
                        windGust = Welcome.wind.gust
                        seaLevel = Welcome.main.seaLevel
                        grndLevel = Welcome.main.grndLevel
                        pressure = Welcome.main.pressure
                    } catch {
                        // 处理解码错误
                        print("解码失败: \(error.localizedDescription)")
                        print("错误详情: \(error)")
                    }
                } else {
                    // 处理字符串转数据失败的情况
                    print("无法将字符串转换为数据")
                }
                
                
                //print(Main)
            }
            
            getCity(lat: locationManager.location!.coordinate.latitude, lon: locationManager.location!.coordinate.longitude) { result in
                switch result {
                case .success(let city):
                    print("对应的城市: \(city)")  // 输出: 北京市
                    cityName = city
                case .failure(let error):
                    print("错误: \(error.localizedDescription)")
                }
            }
        })
        .onAppear{
            locationManager.requestPermission()
        }
    }
    var humidityGauge: some View{
        Gauge(value: Double(humidity ?? 0), in: 0...100) {
            Text("濕度")
                .foregroundStyle(.white)
        } currentValueLabel: {
            Text(" \(humidity ?? 0)%")
                .foregroundStyle(.white)
        } minimumValueLabel: {
            Text("\(0)")
                .foregroundStyle(.white)
        } maximumValueLabel: {
            Text("\(100)")
                .foregroundStyle(.white)
        }
        .tint(.white)
        .gaugeStyle(.accessoryCircular)
    }
}

#Preview {
    ContentView()
}
