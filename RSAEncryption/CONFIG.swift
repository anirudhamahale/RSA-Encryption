//
//  CONFIG.swift
//  RSAEncryption
//
//  Created by Anirudha on 18/05/18.
//  Copyright © 2018 Anirudha Mahale. All rights reserved.
//

import Foundation

/// This function converts the unsigned integer to Data.
///
/// The Data is then converted to encoded to base64 Data.
///
/// The base64 Data is encoded to String.
///
/// - Parameter UInt: array of 8 bit unsigned integer
/// - Returns: The base64 string
func getBase64StringOf(UInt: [UInt8]) -> String? {
    // Convert array of unsigned integer to Data.
    let data = Data(bytes: UInt)
    
    //Encode Data to base64 Data.
    let base64Data = data.base64EncodedData(options: Data.Base64EncodingOptions.endLineWithLineFeed)
    
    // Convert Data to String.
    return String(data: base64Data, encoding: String.Encoding.utf8)
}
