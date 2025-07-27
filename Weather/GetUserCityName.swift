//
//  GetUserCityName.swift
//  Weather
//
//  Created by Daniel on 26/7/2025.
//

import CoreLocation

/// 通过经纬度获取城市名称
/// - Parameters:
///   - lat: 纬度
///   - lon: 经度
///   - completion: 完成回调，返回城市名称或错误信息
func getCity(lat: Double, lon: Double, completion: @escaping (Result<String, Error>) -> Void) {
    // 验证经纬度范围
    guard (lat >= -90 && lat <= 90) && (lon >= -180 && lon <= 180) else {
        completion(.failure(NSError(domain: "InvalidCoordinates", code: 0, userInfo: [NSLocalizedDescriptionKey: "经纬度超出有效范围"])))
        return
    }
    
    let location = CLLocation(latitude: lat, longitude: lon)
    let geocoder = CLGeocoder()
    
    geocoder.reverseGeocodeLocation(location) { placemarks, error in
        if let error = error {
            completion(.failure(error))
            return
        }
        
        guard let placemark = placemarks?.first else {
            completion(.failure(NSError(domain: "NoLocationData", code: 1, userInfo: [NSLocalizedDescriptionKey: "未找到位置信息"])))
            return
        }
        
        // 优先获取城市信息
        if let city = placemark.locality {
            completion(.success(city))
        }
        // 某些地区可能使用administrativeArea作为城市级别
        else if let adminArea = placemark.administrativeArea {
            completion(.success(adminArea))
        }
        // 最后尝试获取国家信息作为 fallback
        else if let country = placemark.country {
            completion(.success(country))
        }
        else {
            completion(.failure(NSError(domain: "NoCityFound", code: 2, userInfo: [NSLocalizedDescriptionKey: "无法确定城市"])))
        }
    }
}

// 使用示例
// getCity(lat: 39.9042, lon: 116.4074) { result in
//     switch result {
//     case .success(let city):
//         print("对应的城市: \(city)")  // 输出: 北京市
//     case .failure(let error):
//         print("错误: \(error.localizedDescription)")
//     }
// }
