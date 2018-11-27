//
//  Model.swift
//  SuryaAssignToMe
//
//  Created by kashee on 27/11/18.
//  Copyright © 2018 kashee. All rights reserved.
//

import UIKit

class UserData:NSObject {
    var emailId:String?
    var firstName:String?
    var lastName:String?
    var imageUrl:String?
    
    func initDic(result:NSDictionary) {
        emailId = result["emailId"] as? String
        firstName = result["firstName"] as? String
        lastName = result["lastName"] as? String
        imageUrl = result["imageUrl"] as? String
    }
}
