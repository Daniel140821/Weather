//
//  API_Func.swift
//  Weather
//
//  Created by Daniel on 26/7/2025.
//

import Foundation

func fetchData(apiURL:String) async -> String {
    var dataString : String?
    guard let url = URL(string: apiURL) else {
        dataString = "錯誤的URL"
        //print(dataString!)
        return ""
    }
    
    do {
        let (data, _) = try await URLSession.shared.data(from: url)
        if let decodedString = String(data: data, encoding: .utf8) {
            dataString = decodedString
            //print(dataString!)
            return dataString!
        } else {
            dataString = "無法解碼"
            //print(dataString!)
            return dataString!
        }
    } catch {
        dataString = "請求錯誤: \(error.localizedDescription)"
        //print(dataString!)
        return dataString!
    }
}
