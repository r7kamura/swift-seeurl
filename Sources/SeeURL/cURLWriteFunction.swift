//
//  cURLWriteFunction.swift
//  SwiftFoundation
//
//  Created by Alsey Coleman Miller on 8/4/15.
//  Copyright © 2015 PureSwift. All rights reserved.
//  Copyright © 2016 Shiroyagi Corporation. All rights reserved.
//

import CcURL
import Foundation
import CoreFoundation

public extension cURL {
    
    public typealias WriteCallBack = curl_write_callback
    
    public static var WriteFunction: WriteCallBack { return curlWriteFunction }
    
    public final class WriteFunctionStorage {
        
        public let data = NSMutableData()
        
        public init() { }
    }
}

public func curlWriteFunction(contents: UnsafeMutablePointer<Int8>?, size: Int, nmemb: Int, readData: UnsafeMutableRawPointer?) -> Int {
    
    guard let contents = contents, let readData = readData else {
        return 0
    }
    
    let storage = Unmanaged<cURL.WriteFunctionStorage>.fromOpaque(readData).takeUnretainedValue()
    
    let realsize = size * nmemb
    
    storage.data.append(contents, length: realsize)
    
    return realsize
}
