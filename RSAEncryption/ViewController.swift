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
    
    /*
     * This function will encrypt the message with RSA encryption.
     */
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
    }
    
    /*
     * This function will generate the RSA public and private key
     */
    func generateSecKeys() {
        //Generation of RSA private and public keys
        let parameters: [String: Any] = [
            kSecAttrKeyType as String : kSecAttrKeyTypeRSA,
            kSecAttrKeySizeInBits as String : 2048
        ]
        
        // This function will create random keys based on the parameters send to it
        SecKeyGeneratePair(parameters as CFDictionary, &publicKey, &privateKey)
    }
}

