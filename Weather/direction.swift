//
//  direction.swift
//  Weather
//
//  Created by Daniel on 27/7/2025.
//

import Foundation

struct DegreeAndDirection: Equatable, Codable {
    let minDegree: Int  // 范围最小值
    let maxDegree: Int  // 范围最大值
    let direction: String
    
    // 用两个独立值存储范围，兼容反向范围（如336到25）
    static let examples = [
        DegreeAndDirection(minDegree: 336, maxDegree: 25, direction: "北"),//北
        DegreeAndDirection(minDegree: 26, maxDegree: 65, direction: "東北"),//东北
        DegreeAndDirection(minDegree: 66, maxDegree: 115, direction: "東"),//东
        DegreeAndDirection(minDegree: 116, maxDegree: 155, direction: "東南"),//东南
        DegreeAndDirection(minDegree: 156, maxDegree: 205, direction: "南"),//南
        DegreeAndDirection(minDegree: 206, maxDegree: 245, direction: "西南"),//西南
        DegreeAndDirection(minDegree: 246, maxDegree: 295, direction: "西"),//西
        DegreeAndDirection(minDegree: 296, maxDegree: 335, direction: "西北")//西北
    ]
    
    // 安全的方向查询方法
    static func findDirection(for degree: Int) -> String {
        for item in examples {
            if item.minDegree <= item.maxDegree {
                // 正向范围：直接判断是否在 [min, max] 之间
                if degree >= item.minDegree && degree <= item.maxDegree {
                    return item.direction
                }
            } else {
                // 反向范围（如336-25）：判断是否 >= min 或 <= max
                if degree >= item.minDegree || degree <= item.maxDegree {
                    return item.direction
                }
            }
        }
        return "未知"
    }
}
