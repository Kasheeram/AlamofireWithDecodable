//
//  ServerInterface.swift
//  iOSCodingPractice
//
//  Created by kashee on 27/11/18.
//  Copyright © 2018 kashee. All rights reserved.
//

import UIKit
import Alamofire


var baseURL = "http://surya-interview.appspot.com/"
var getUserList = "list"
var SERVER_ERROR = "Some thing went wrong, please try again"


@objc protocol ServerAPIDelegate {
    func API_CALLBACK_Error(errorNumber:Int,errorMessage:String,
                            apiName : String)
    
    @objc optional func API_CALLBACK_POST_Data(result : Data)
    
}

class ServerInterface: NSObject {
    
    static let sharedInstance = ServerInterface()
    
    func API_Request(params : [String : AnyObject], delegate : ServerAPIDelegate,apiName : String = "", needErrorAlert : Bool = true ) {
        
        let urlString:String = baseURL + apiName
        
        Alamofire.request(urlString, method: .post, parameters: params, encoding: JSONEncoding.default,headers: nil).validate().responseJSON{
            response in
            switch response.result{
            case .success:
                let data = response.data
                self.findCallbackForApiName(apiName: apiName, resultDict: data as! Data, delegate: delegate)
            break
            case .failure(let error):
                delegate.API_CALLBACK_Error(errorNumber: 0,errorMessage:SERVER_ERROR,apiName : apiName )
            }
        }
        
    }
    

    func findCallbackForApiName(apiName : String, resultDict : Data,delegate : ServerAPIDelegate){
        delegate.API_CALLBACK_POST_Data!(result: resultDict)
    }
}
