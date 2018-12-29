//
//  Model.swift
//  SuryaAssignToMe
//
//  Created by kashee on 27/11/18.
//  Copyright © 2018 kashee. All rights reserved.
//

import UIKit

class UserData:Decodable {
    
    var items:[data1]?
}

class data1:Decodable{
    var emailId:String?
    var firstName:String?
    var lastName:String?
    var imageUrl:String?
}
