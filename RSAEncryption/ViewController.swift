//
//  ViewController.swift
//  RSAEncryption
//
//  Created by Anirudha on 18/05/18.
//  Copyright © 2018 Anirudha Mahale. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var publicKey, privateKey: SecKey?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        generateSecKeys()
        encrypt(string: "This is my message.")
    }
    
    /// This function will encrypt the message with RSA encryption.
    ///
    /// - Parameter string: String that needs to be encrypted.
    func encrypt(string: String) {
        //Encrypt a string with the public key
        let blockSize = SecKeyGetBlockSize(publicKey!)
        var messageEncrypted = [UInt8](repeating: 0, count: blockSize)
        var messageEncryptedSize = blockSize
        
        var status: OSStatus!
        
        status = SecKeyEncrypt(publicKey!, SecPadding.PKCS1, string, string.count, &messageEncrypted, &messageEncryptedSize)
        
        if status != noErr {
            print("Encryption Error!")
            return
        }
        
        print("Encrypted")
        if let base64 = getBase64StringOf(UInt: messageEncrypted) {
            print("base64 String: ")
            print(base64)
        }
    }
    
    /// Generates the random public and private RSA keys and assigns it to the specified property.
    ///
    /// publicKey will hold the RSA Public key.
    ///
    /// privateKey will hold the RSA Private key.
    func generateSecKeys() {
        //Generation of RSA private and public keys.
        let parameters: [String: Any] = [
            kSecAttrKeyType as String : kSecAttrKeyTypeRSA,
            kSecAttrKeySizeInBits as String : 2048
        ]
        
        // This function will create random public, private keys based on the parameters send to it.
        SecKeyGeneratePair(parameters as CFDictionary, &publicKey, &privateKey)
    }
    
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
}

