////
////  ShareViewController.swift
////  tumi_share
////
////  Created by Julian Garcia-Haugland on 6/1/26.
////
//
//import UIKit
//import UniformTypeIdentifiers
//class ShareViewController: UIViewController{
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        guard
//            let extensionItem = extensionContext?.inputItems.first as? NSExtensionItem,
//            let itemProvider = extensionItem.attachments?.first else {
//            close()
//            return
//        }
//            let textDataType = UTType.plainText.identifier
//            let image = UTType.image.identifier
//            if (itemProvider.hasItemConformingToTypeIdentifier(textDataType) || itemProvider.hasItemConformingToTypeIdentifier(image)){
//                if(itemProvider.hasItemConformingToTypeIdentifier(textDataType)){
//                    
//                }
//            }
//            else{
//                close()
//            }
//            return
//            
//        }
//    }
//    func close(){
//        self.extensionContext?.completeRequest(returningItems: [], completionHandler: nil)
//    }
//
