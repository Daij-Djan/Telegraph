//
//  UInt+Ext.swift
//  Telegraph
//
//  Created by Yvo van Beek on 2/17/17.
//  Copyright © 2017 Building42. All rights reserved.
//

import Foundation

extension UInt8 {
  public static var random: UInt8 {
    var number: UInt8 = 0
    _ = SecRandomCopyBytes(kSecRandomDefault, 1, &number)
    return number
  }
}

extension UInt16 {
  public var bytes: [UInt8] {
    return [
      UInt8(truncatingBitPattern: self >> 8),
      UInt8(truncatingBitPattern: self)
    ]
  }
}

extension UInt32 {
  public var bytes: [UInt8] {
    return [
      UInt8(truncatingBitPattern: self >> 24),
      UInt8(truncatingBitPattern: self >> 16),
      UInt8(truncatingBitPattern: self >> 8),
      UInt8(truncatingBitPattern: self)
    ]
  }
}

extension UInt64 {
  public var bytes: [UInt8] {
    return (0..<8).reversed().map { UInt8(truncatingBitPattern: self >> 8 * $0) }
  }
}
