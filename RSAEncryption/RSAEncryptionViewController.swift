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
    
    func encrypt(message: String, publicKey: String) -> String? {
        let PUBLIC_KEY = getKeyStringFromPEM(name: publicKey)
        
        let data = message.data(using: String.Encoding.utf8)!
        guard let encryptedData = RSAUtils.encryptWithRSAPublicKey(data, pubkeyBase64: PUBLIC_KEY, keychainTag: "sdlkfjslkd") else {
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
    
    func getKeyStringFromPEM(name: String) -> String {
        let bundle = Bundle.main
        
        let keyPath = bundle.path(forResource: name, ofType: "pem")!
        let keyString = try! NSString(contentsOfFile: keyPath, encoding: String.Encoding.utf8.rawValue)
        let keyArray = keyString.components(separatedBy: "\n") //Remove new line characters
        
        var keyOutput : String = ""
        
        for item in keyArray {
            if !item.contains("-----") { //Example: -----BEGIN PUBLIC KEY-----
                keyOutput += item //Join elements of the text array together as a single string
            }
        }
        return keyOutput
    }
}
