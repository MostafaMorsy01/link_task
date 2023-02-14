//
//  BaseNetwork.swift
//  El Rass
//
//  Created by admin on 16/08/2022.
//

import Foundation
import Alamofire

final class BaseNetwork<T:TargetType>{

    static func request<M:Codable,E:Codable>(Target:T,responseModel:M.Type,ModelError:E.Type,completion: @escaping ( Bool , M?, String?) -> ()) {
        let method = Alamofire.HTTPMethod(rawValue: Target.method.rawValue)
        let parameters = buildparameters(paramaters: Target.parameter)
        let headers = Alamofire.HTTPHeaders(Target.header ?? [:])
    
        
        
        AF.request(Target.url, method: method ,parameters: parameters.0, encoding: parameters.1, headers: headers)
            .responseDecodable(completionHandler: { ( response : DataResponse<M?, AFError>) in
                    switch response.result{
                    case .success(let model):
                        if response.response?.statusCode == 200{ // success
                            guard model != nil else {return}
                            completion(true, model , "success")
                            
                        }else if response.response?.statusCode == 400  { // bad request
                            guard model != nil else {return}
                        completion(false,model,"Bad Request" )

                        }else{
                            completion(false, nil, "serialization error" )
                        }

                    case .failure(let err):
                        if response.response?.statusCode == 401 {  //Unauthorized
                            completion(false, nil, "Unauthorized")

                        }else{
                            completion(false, nil, err.localizedDescription)
                            print(err)
                        }
                    }
            })
    }
    static func request1<M:Decodable>(Target:T,responseModel:M.Type,completion: @escaping ( Bool , M?, String?) -> ()) {
        let method = Alamofire.HTTPMethod(rawValue: Target.method.rawValue)
        let parameters = buildparameters(paramaters: Target.parameter)
        let headers = Alamofire.HTTPHeaders(Target.header ?? [:])
    
        
        
        AF.request(Target.url, method: method ,parameters: parameters.0, encoding: parameters.1, headers: headers)
            .responseDecodable(completionHandler: { ( response : DataResponse<M?, AFError>) in
                    switch response.result{
                    case .success(let model):
                        if response.response?.statusCode == 200{ // success
                            guard model != nil else {return}
                            completion(true, model , "success")
                            
                        }else if response.response?.statusCode == 400  { // bad request
                            guard model != nil else {return}
                        completion(false,model,"Bad Request" )

                        }else{
                            completion(false, nil, "serialization error" )
                        }

                    case .failure(let err):
                        if response.response?.statusCode == 401 {  //Unauthorized
                            completion(false, nil, "Unauthorized")

                        }else{
                            completion(false, nil, err.localizedDescription)
                            print(err)
                        }
                    }
            })
    }
    
    static func multipartRequest<M:Codable>(Target:T,responseModel:M.Type,completion: @escaping ( Bool , M?, String?) -> ()) {
        let method = Alamofire.HTTPMethod(rawValue: Target.method.rawValue)
        let parameters = buildparameters(paramaters: Target.parameter)
        let headers = Alamofire.HTTPHeaders(Target.header ?? [:])
        
        
        AF.upload(multipartFormData: { (multipartFormData) in
            for (key , value) in parameters.0{
                
                if let temp = value as? String {
                    multipartFormData.append(temp.data(using: .utf8)!, withName: key)
                }
                if let temp = value as? Int {
                    multipartFormData.append("\(temp)".data(using: .utf8)!, withName: key)
                }
                if let temp = value as? NSArray{
                    temp.forEach({ element in
                        let keyObj = key + "[]"
                        if let string = element as? String {
                            multipartFormData.append(string.data(using: .utf8)!, withName: keyObj)
                        } else
                        if let num = element as? Int {
                            let value = "\(num)"
                            multipartFormData.append(value.data(using: .utf8)!, withName: keyObj)
                        }
                    })
                }
            }
//                if let data = image?.jpegData(compressionQuality: 0.8), image != nil {
//                    //be carefull and put file name in withName parmeter
//                    multipartFormData.append(data, withName: withName , fileName: "file.jpeg", mimeType: "image/jpeg")
//                }else{
//                    print("cant get image data")
//                    completion(false, nil,"imageError")
//                }
            
        },     to: Target.url,
                  method: method,
                  headers: headers
        )
                
        
//            .uploadProgress(queue: .main, closure: { progress in
//                //Current upload progress of file
//                print("Upload Progress: \(progress.fractionCompleted)")
//            })
            .responseDecodable(completionHandler: { ( response : DataResponse<M?, AFError>) in
                    switch response.result{
                    case .success(let model):
                        if response.response?.statusCode == 200{ // success
                            guard model != nil else {return}
                            completion(true, model , "success")
                            print("success")
                            
                        }else if response.response?.statusCode == 400  { // bad request
                            guard model != nil else {return}
                        completion(false,model,"Bad Request" )
                            print("badd")

                        }else{
                            completion(false, nil, "serialization error" )
                            print("!!!!!!!!!!")
                        }

                    case .failure(let err):
                        if response.response?.statusCode == 401 {  //Unauthorized
                            completion(false, nil, "Unauthorized")
                            print("UnAuthhhhh")

                        }else{
                            completion(false, nil, err.localizedDescription)
                            print("??????????")
                            print(err)
                        }
                    }
            })
    }
    
    static func multipartRequest1<M:Decodable>(Target:T,responseModel:M.Type,completion: @escaping ( Bool , M?, String?) -> ()) {
        let method = Alamofire.HTTPMethod(rawValue: Target.method.rawValue)
        let parameters = buildparameters(paramaters: Target.parameter)
        let headers = Alamofire.HTTPHeaders(Target.header ?? [:])
        
        
        AF.upload(multipartFormData: { (multipartFormData) in
            for (key , value) in parameters.0{
                
                if let temp = value as? String {
                    multipartFormData.append(temp.data(using: .utf8)!, withName: key)
                }
                if let temp = value as? Int {
                    multipartFormData.append("\(temp)".data(using: .utf8)!, withName: key)
                }
                if let temp = value as? NSArray{
                    temp.forEach({ element in
                        let keyObj = key + "[]"
                        if let string = element as? String {
                            multipartFormData.append(string.data(using: .utf8)!, withName: keyObj)
                        } else
                        if let num = element as? Int {
                            let value = "\(num)"
                            multipartFormData.append(value.data(using: .utf8)!, withName: keyObj)
                        }
                    })
                }
            }
//                if let data = image?.jpegData(compressionQuality: 0.8), image != nil {
//                    //be carefull and put file name in withName parmeter
//                    multipartFormData.append(data, withName: withName , fileName: "file.jpeg", mimeType: "image/jpeg")
//                }else{
//                    print("cant get image data")
//                    completion(false, nil,"imageError")
//                }
            
        },     to: Target.url,
                  method: method,
                  headers: headers
        )
                
        
//            .uploadProgress(queue: .main, closure: { progress in
//                //Current upload progress of file
//                print("Upload Progress: \(progress.fractionCompleted)")
//            })
            .responseDecodable(completionHandler: { ( response : DataResponse<M?, AFError>) in
                    switch response.result{
                    case .success(let model):
                        if response.response?.statusCode == 200{ // success
                            guard model != nil else {return}
                            completion(true, model , "success")
                            print("success")
                            
                        }else if response.response?.statusCode == 400  { // bad request
                            guard model != nil else {return}
                        completion(false,model,"Bad Request" )
                            print("badd")

                        }else{
                            completion(false, nil, "serialization error" )
                            print("!!!!!!!!!!")
                        }

                    case .failure(let err):
                        if response.response?.statusCode == 401 {  //Unauthorized
                            completion(false, nil, "Unauthorized")
                            print("UnAuthhhhh")

                        }else{
                            completion(false, nil, err.localizedDescription)
                            print("??????????")
                            print(err)
                        }
                    }
            })
    }
    static func multipartRequestImage<M:Codable>(Target:T,image:UIImage?,withName:String,responseModel:M.Type,completion: @escaping ( Bool , M?, String?) -> ()) {
        let method = Alamofire.HTTPMethod(rawValue: Target.method.rawValue)
        let parameters = buildparameters(paramaters: Target.parameter)
        let headers = Alamofire.HTTPHeaders(Target.header ?? [:])
        
        
        AF.upload(multipartFormData: { (multipartFormData) in
            for (key , value) in parameters.0{
                
                if let temp = value as? String {
                    multipartFormData.append(temp.data(using: .utf8)!, withName: key)
                }
                if let temp = value as? Int {
                    multipartFormData.append("\(temp)".data(using: .utf8)!, withName: key)
                }
                if let temp = value as? NSArray{
                    temp.forEach({ element in
                        let keyObj = key + "[]"
                        if let string = element as? String {
                            multipartFormData.append(string.data(using: .utf8)!, withName: keyObj)
                        } else
                        if let num = element as? Int {
                            let value = "\(num)"
                            multipartFormData.append(value.data(using: .utf8)!, withName: keyObj)
                        }
                    })
                }
            }
                if let data = image?.jpegData(compressionQuality: 0.8), image != nil {
                    //be carefull and put file name in withName parmeter
                    multipartFormData.append(data, withName: withName , fileName: "file.jpeg", mimeType: "image/jpeg")
                }else{
                    print("cant get image data")
                    completion(false, nil,"imageError")
                }
            
        },     to: Target.url,
                  method: method,
                  headers: headers
        )
                
        
            .uploadProgress(queue: .main, closure: { progress in
                //Current upload progress of file
                print("Upload Progress: \(progress.fractionCompleted)")
            })
            .responseDecodable(completionHandler: { ( response : DataResponse<M?, AFError>) in
                    switch response.result{
                    case .success(let model):
                        if response.response?.statusCode == 200{ // success
                            guard model != nil else {return}
                            completion(true, model , "success")
                            print("success")
                            
                        }else if response.response?.statusCode == 400  { // bad request
                            guard model != nil else {return}
                        completion(false,model,"Bad Request" )
                            print("badd")

                        }else{
                            completion(false, nil, "serialization error" )
                            print("!!!!!!!!!!")
                        }

                    case .failure(let err):
                        if response.response?.statusCode == 401 {  //Unauthorized
                            completion(false, nil, "Unauthorized")
                            print("UnAuthhhhh")

                        }else{
                            completion(false, nil, err.localizedDescription)
                            print("??????????")
                            print(err)
                        }
                    }
            })
    }
    
    
    static func multipartRequestImageArr<M:Codable>(Target:T,image:UIImage?,imagesData:[UIImage]?,withName:String,responseModel:M.Type,completion: @escaping ( Bool , M?, String?) -> ()) {
        let method = Alamofire.HTTPMethod(rawValue: Target.method.rawValue)
        let parameters = buildparameters(paramaters: Target.parameter)
        let headers = Alamofire.HTTPHeaders(Target.header ?? [:])
        
        
        AF.upload(multipartFormData: { (multipartFormData) in
            for (key , value) in parameters.0{
                
                if let temp = value as? String {
                    multipartFormData.append(temp.data(using: .utf8)!, withName: key)
                }
                if let temp = value as? Int {
                    multipartFormData.append("\(temp)".data(using: .utf8)!, withName: key)
                }
                if let temp = value as? NSArray{
                    temp.forEach({ element in
                        let keyObj = key + "[]"
                        if let string = element as? String {
                            multipartFormData.append(string.data(using: .utf8)!, withName: keyObj)
                        } else
                        if let num = element as? Int {
                            let value = "\(num)"
                            multipartFormData.append(value.data(using: .utf8)!, withName: keyObj)
                        }
                    })
                }
            }
                
//            let count = imagesData?.count
//
//            for i in 0..<count!{
//
//                multipartFormData.append((imagesData?[i])! as! URL, withName: "photo[\(i)]", fileName: "photo\(i).jpeg", mimeType: "image/jpeg")
//                    }
//            // import image to request
            for (index,image) in imagesData!.enumerated() {


                if let imageData = image.jpegData(compressionQuality: 1) {
                    multipartFormData.append(imageData, withName: "image[\(index)]", fileName: "file.jpg", mimeType: "image/jpeg")

                }

            }
            if let data = image?.jpegData(compressionQuality: 0.8), image != nil {
                    //be carefull and put file name in withName parmeter
                    multipartFormData.append(data, withName: withName , fileName: "file.jpeg", mimeType: "image/jpeg")
                }else{
                    print("cant get image data")
//                    completion(false, nil,"imageError")
                }
            
        },
                  to: Target.url,
                  method: method,
                  headers: headers
        )
    
        
            .uploadProgress(queue: .main, closure: { progress in
                //Current upload progress of file
                print("Upload Progress: \(progress.fractionCompleted)")
            })
            .validate(statusCode: 200..<300)
            .responseDecodable(completionHandler: { ( response : DataResponse<M?, AFError>) in
                    switch response.result{
                    case .success(let model):
                        if response.response?.statusCode == 200{ // success
                            guard model != nil else {return}
                            completion(true, model , "success")
                            print("success")
                            
                        }else if response.response?.statusCode == 400  { // bad request
                            guard model != nil else {return}
                        completion(false,model,"Bad Request" )
                            print("badd")

                        }else{
                            completion(false, nil, "serialization error" )
                            print("!!!!!!!!!!")
                        }

                    case .failure(let err):
                        if response.response?.statusCode == 401 {  //Unauthorized
                            completion(false, nil, "Unauthorized")
                            print("UnAuthhhhh")

                        }else{
                            completion(false, nil, err.localizedDescription)
                            print("??????????")
                            print(err)
                        }
                    }
            })
    }
    
    
    
    static func buildparameters(paramaters:parameterType)->([String:Any],ParameterEncoding){
        switch paramaters{
        case .plainRequest:
            return ([:],URLEncoding.default)
        case .plainRequest1:
            return ([:],URLEncoding.default)
        case .parameterRequest(Parameters: let Parameters, Encoding: let Encoding):
            return(Parameters,Encoding)
        }
    }
    
    }
