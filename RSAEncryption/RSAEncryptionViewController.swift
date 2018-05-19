//
//  RSAEncryptionViewController.swift
//  RSAEncryption
//
//  Created by Anirudha on 18/05/18.
//  Copyright © 2018 Anirudha Mahale. All rights reserved.
//

import UIKit

class RSAEncryptionViewController: UIViewController {

    // tag name to access the stored private key stored in keychain
    let TAG_PRIVATE_KEY = "com.anirudha.private"
    
    // tag name to access the stored public key in keychain
    let TAG_PUBLIC_KEY = "Imported Public Key"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if let encryptedString = encrypt(message: "Anirudha", publicKey: "public_key") {
            print(encryptedString)
        } else {
            print("Failed to encrypt.")
        }
    }
    
    
    /// Does the RSA encryption of the message passed with the public key.
    ///
    /// - Parameters:
    ///   - message: String to be encrypted.
    ///   - publicKey: Name of the public key without extension.
    /// - Returns: The base64String of the encrypted string.
    func encrypt(message: String, publicKey: String) -> String? {
        guard let PUBLIC_KEY = getKeyStringFromPEM(name: publicKey) else {
            return nil
        }
        
        let data = message.data(using: String.Encoding.utf8)!
        guard let encryptedData = RSAUtils.encryptWithRSAPublicKey(data, pubkeyBase64: PUBLIC_KEY, keychainTag: TAG_PUBLIC_KEY) else {
            print("encryptedData Unexpectedly found nil")
            return nil
        }
        
        let base64Data = encryptedData.base64EncodedData(options: Data.Base64EncodingOptions.endLineWithLineFeed)
        
        guard let base64String = String(data: base64Data, encoding: String.Encoding.utf8) else {
            print("base64String Unexpectedly found nil")
            return nil
        }
        
        return base64String
    }
    
    
    /// Finds the pem file in the bundle.
    ///
    /// - Parameter name: Name of the pem file without extension.
    /// - Returns: The string of the pem file.
    func getKeyStringFromPEM(name: String) -> String? {
        guard let keyPath = Bundle.main.path(forResource: name, ofType: "pem") else {
            print("\(name).pem not found in application bundle directory.")
            return nil
        }
        
        do {
            let keyString = try String(contentsOfFile: keyPath, encoding: String.Encoding.utf8)
            let keyArray = keyString.components(separatedBy: "\n") //Remove new line characters
            
            var keyOutput : String = ""
            
            for item in keyArray {
                if !item.contains("-----") { //Example: -----BEGIN PUBLIC KEY-----
                    keyOutput += item //Join elements of the text array together as a single string
                }
            }
            return keyOutput
        } catch {
            print("\(name).pem not found in application bundle directory.")
            return nil
        }
    }
}
