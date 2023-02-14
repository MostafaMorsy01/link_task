//
//  LoginViewModel.swift
//  link_task
//
//  Created by admin on 14/02/2023.
//

import Foundation
import Combine
import Alamofire



class ViewModelLogin: ObservableObject {
    var language = LocalizationService.shared.language
    let passthroughSubject = PassthroughSubject<String, Error>()
    let passthroughModelSubject = PassthroughSubject<LoginModel, Error>()
    private var cancellables: Set<AnyCancellable> = []
    
    
    // ------- input
    @Published  var fullName: String = ""{
        didSet{
            if self.fullName.isEmpty{
                self.nameErrorMessage = "*"
            } else {
                self.nameErrorMessage = ""
            }
        }
    }
    @Published  var email: String = "" {
        didSet{
            if self.email.isEmpty{
                self.emailErrorMessage = "*"
            } else if !self.email.isValidEmail(){
                self.emailErrorMessage = "Invalid Email"
            } else {
                self.emailErrorMessage = ""
            }
        }
    }
    @Published  var phoneNumber: String = "" {
        didSet{
            let filtered = phoneNumber.filter {$0.isNumber}
            if phoneNumber != filtered {
                phoneNumber = filtered
            }
            if   self.phoneNumber.count < 9 || self.phoneNumber.count > 10 {
                self.phoneErrorMessage = "phone_number_error".localized(language)
            } else if self.phoneNumber.isEmpty {
                self.phoneErrorMessage = "*"
            } else if self.phoneNumber.count == 10 || self.phoneNumber.count == 9  {
                self.phoneErrorMessage = ""
            }
        }
    }
    @Published  var phoneNumber1: String = "+20 | "
    @Published  var password = ""
    @Published  var password1 = ""
    @Published  var countryCode = ""
 
    
    //------- output
    @Published var nameErrorMessage = ""
    @Published var emailErrorMessage = ""
    @Published var phoneErrorMessage = ""
    @Published var isValid = false
    @Published var inlineErrorPassword = ""
    @Published var publishedUserRegisteredModel: LoginModel? = nil
    @Published var isRegistered = false
   
    @Published private var UserCreated = false
   
    @Published var isLoading:Bool? = false
    @Published var isAlert = false
//    @Published var activeAlert: ActiveAlert = .NetworkError
    @Published var message = ""

    init() {
        

     validations()
        //-----------------------------------------------------------------
        passthroughModelSubject.sink { (completion) in

        } receiveValue: { (modeldata) in
            self.publishedUserRegisteredModel = modeldata
            
            print(self.publishedUserRegisteredModel as Any)
        }.store(in: &cancellables)
        
   
        
        
    }
    
    func isValidPhone(phone: String) -> Bool {
            let phoneRegex = "^[0-9+]{0,1}+[0-9]{5,16}$"
            let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
            return phoneTest.evaluate(with: phone)
        }

    func isValidEmail(email: String) -> Bool {
            let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
            let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
            return emailTest.evaluate(with: email)
        }

    func validations(){
        
         var isFullNameValidPublisher: AnyPublisher<Bool,Never> {
            $fullName
                .debounce(for: 0.8, scheduler: RunLoop.main)
                .removeDuplicates()
                .map{ $0.count >= 4}
                .eraseToAnyPublisher()
        }

         var isPhoneNumberValidPublisher: AnyPublisher<Bool,Never> {
            $phoneNumber
                .debounce(for: 0.8, scheduler: RunLoop.main)
                .removeDuplicates()
                .map{ $0.count == 11 }
                .eraseToAnyPublisher()
        }
         var isPasswordEmptyPublisher: AnyPublisher<Bool,Never> {
            $password
                .debounce(for: 0.8, scheduler: RunLoop.main)
                .removeDuplicates()
                .map{ $0.isEmpty && $0.count >= 6}
                .eraseToAnyPublisher()
        }
         var arePasswordsEqualPublisher: AnyPublisher<Bool,Never> {
            Publishers.CombineLatest($password, $password1)
                .debounce(for: 0.2, scheduler: RunLoop.main)
                .map{ $0 == $1}
                .eraseToAnyPublisher()
        }
         var isPasswordsValidPublisher: AnyPublisher<PasswordStatus,Never> {
            Publishers.CombineLatest(isPasswordEmptyPublisher, arePasswordsEqualPublisher)
                .map{
                    if $0 {return PasswordStatus.empty}
                    if !$1 {return PasswordStatus.repeatedPasswordWrong}
                    return PasswordStatus.valid
                }
                .eraseToAnyPublisher()
        }
        
         var isFormValidPublisher: AnyPublisher<Bool,Never> {
            Publishers.CombineLatest3(isPasswordsValidPublisher,isFullNameValidPublisher,isPhoneNumberValidPublisher)
                .map{ $0 == .valid && $1 && $2}
                .eraseToAnyPublisher()
        }
        
        enum PasswordStatus {
            case notemail
            case empty
            case repeatedPasswordWrong
            case valid
        }
        
        //----------
        isFormValidPublisher
            .receive(on: RunLoop.main)
            .assign(to: \.isValid, on: self)
            .store(in: &cancellables)
        
        isPasswordsValidPublisher
            .dropFirst()
            .receive(on: RunLoop.main)
            .map{ passwordStatus in
                switch passwordStatus {
                case .notemail:
                    return "Not Valid Email"
                case .empty:
                    return "Password cannot be Empty"
                case .repeatedPasswordWrong:
                    return "Passwords do not match"
                case .valid:
                    return ""
                }
            }
            .assign(to: \.inlineErrorPassword, on: self)
            .store(in: &cancellables)
        
        
        
    }
}

extension ViewModelLogin:TargetType{
   
    
    
    
    
    var url: String {
        return  URLs().Login
    }
    
    var method: httpMethod {
        return .Post
    }
    
    var parameter: parameterType {
        let parametersarr : [String : Any] = ["phone":"\(countryCode)" + phoneNumber ]

        return .parameterRequest(Parameters: parametersarr, Encoding: JSONEncoding.default)
    }
    
    var header: [String : String]? {
        let header = ["Content-Type":"multipart/form-data" , "lang":Helper.getLanguage(), "Accept": "*/*"]
        return header
    }
    
    func startFetchUserRegisteration(){
        
       
        self.isLoading = true
        BaseNetwork.request(Target: self, responseModel: LoginModel.self,ModelError: ErrorModel.self) { [self] (success, model, err) in
                if success{
                    //case of success
                    DispatchQueue.main.async {
                        self.isRegistered = true
                        self.passthroughModelSubject.send(model!)
                        
//                        print(self.passthroughModelSubject)
                        print(model!)
                    }
                }else{
                    if model != nil{
                        //case of model with error
//                        message = model?.msg ?? "Bad Request"
                        isAlert = true
                    }else{
                        if err == "Unauthorized"{
                            //case of Empty model (unauthorized)
                            isAlert = true
                            message = "Session_expired"
                        }else{
                            isAlert = true
                            message = "Your Internet connection has benn lost"
                        }
                    }
                    isAlert = true
                }
                isLoading = false
            }
            
        
    }
    
}
