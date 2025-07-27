//
//  GetUserLocation.swift
//  Weather
//
//  Created by Daniel on 26/7/2025.
//

import SwiftUI
import CoreLocation

// 位置管理器类，处理 Core Location 相关逻辑
class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()
    
    @Published var location: CLLocation?
    @Published var errorMessage: String?
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest // 设置位置精度
    }
    
    // 请求位置权限
    func requestPermission() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    // 检查位置权限状态
    func checkPermission() -> Bool {
        switch locationManager.authorizationStatus {
        case .notDetermined, .denied, .restricted:
            return false
        case .authorizedAlways, .authorizedWhenInUse:
            return true
        @unknown default:
            return false
        }
    }
    
    // 位置更新时调用
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let newLocation = locations.last else {
            errorMessage = "失敗: 無法獲得位置信息"
            return
        }
        location = newLocation
        locationManager.stopUpdatingLocation() // 获取到位置后停止更新
    }
    
    // 位置权限变化时调用
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if checkPermission() {
            locationManager.startUpdatingLocation()
        } else {
            errorMessage = "失敗: 請到設定同意獲取位置"
        }
    }
    
    // 位置获取失败时调用
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        errorMessage = "獲取位置失敗: \(error.localizedDescription)"
    }
}

