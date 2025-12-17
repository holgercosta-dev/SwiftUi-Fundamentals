//
//  ContentView.swift
//  Weather-App
//
//  Created by Roger Knowws on 17/12/2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            BackgroundView(
                topColor: .blue, bottomColor: Color("lightBlue")
            )
            VStack {
                CityName(cityName: "Cupertino, CA")
                WeatherCurrentTemp(imageName: "cloud.sun.fill", temperature: 76)
                WeatherForcastStack()
                Spacer()
                Button {
                    print("tapped")
                } label: {
                    Text("Change Date Time")
                        .frame(width: 280, height: 50)
                        .background(Color.white)
                        .font(.system(size: 20, weight: .bold))
                        .cornerRadius(10)
                }
                Spacer()
            }
        }
    }
}

#Preview {
    ContentView()
}

struct BackgroundView: View {
    var topColor: Color
    var bottomColor: Color
    
    var body: some View {
        LinearGradient(
            colors: [topColor, bottomColor],
            startPoint: .leading,
            endPoint: .bottomTrailing,
        )
        .edgesIgnoringSafeArea(.all)
    }
}

struct WeatherDayView: View {
    var dayOfWeek: String
    var imageName: String
    var temperature: Int

    var body: some View {
        VStack {
            Text(dayOfWeek)
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(.white)
            Image(systemName: imageName)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 40, height: 40)
            Text("\(temperature)°")
                .font(.system(size: 28, weight: .medium))
                .foregroundColor(.white)
        }
    }
}

struct CityName: View {
    var cityName: String
    
    var body: some View {
        Text(cityName)
            .font(.system(size: 32, weight: .medium))
            .foregroundColor(.white)
            .padding()
    }
}

struct WeatherCurrentTemp: View {
    var imageName: String
    var temperature: Int
    
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: imageName)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 180, height: 180)
            Text("\(temperature)°")
                .font(.system(size: 70, weight: .medium))
                .foregroundColor(.white)
        }
        .padding(.bottom, 40)
    }
}

struct WeatherForcastStack: View {
    var body: some View {
        HStack(spacing: 20) {
            WeatherDayView(
                dayOfWeek: "TUE",
                imageName: "cloud.sun.fill",
                temperature: 74
            )
            WeatherDayView(
                dayOfWeek: "WED",
                imageName: "sun.max.fill",
                temperature: 88
            )
            WeatherDayView(
                dayOfWeek: "THU",
                imageName: "wind.snow",
                temperature: 55
            )
            WeatherDayView(
                dayOfWeek: "FRI",
                imageName: "sunset.fill",
                temperature: 60
            )
            WeatherDayView(
                dayOfWeek: "SAT",
                imageName: "cloud.snow.fill",
                temperature: 25
            )
        }
    }
}
