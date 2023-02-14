//
//  Constants.swift
//  El Rass
//
//  Created by admin on 16/08/2022.
//

import Foundation

class URLs {
    // MARK: ------ BASE URL ------
    static let BaseUrl = "https://alrassgate.com"
    
    // MARK: ------ Login And Register End Point ------
    var Login = BaseUrl + "/api/login"
    var Register =  BaseUrl + "/api/register"
    var Verfiy = BaseUrl + "/api/verifyCode"
    var Logout = BaseUrl + "/api/logout"
    
    // MARK: ------ Home End Point ------
    
    var Home = BaseUrl + "/api/home"
    
    // MARK: ------ Offer End Point ------
    
    var Offers = BaseUrl + "/api/offers"
    
    
    // MARK: ------ UnitDetails End Point ------
    
    var details = BaseUrl + "/api/unit"
    var unitDetails = BaseUrl + "/api/myUnitDetails"
    var unitSearch = BaseUrl + "/api/unitsByType"
    var favourite = BaseUrl + "/api/favourite"
    
    // MARK: ------ reservation End Point ------
    
    var reserve = BaseUrl + "/api/reserve"
    var myReserve = BaseUrl + "/api/myreservations"
    var myCoupon = BaseUrl + "/api/discountCode"
    
    
    // MARK: ------ Settings End Point ------
    var myprofile = BaseUrl + "/api/profile"
    var updateProfile = BaseUrl + "/api/updateProfile"
    var settings = BaseUrl + "/api/generalSettings"
    var deleteAccount = BaseUrl + "/api/deleteUser"
    var unitsettings = BaseUrl + "/api/unitSettings"
    var district = BaseUrl + "/api/districts"
    
    
    // MARK: ------ Add Unit End Point ------
    
    var addUnit = BaseUrl + "/api/addUnit"
    var addBooking = BaseUrl + "/api/addBooking"
    var editBooking = BaseUrl + "/api/editBooking"
    var cancelBooking = BaseUrl + "/api//CancelReservation/"
    var updatePrice = BaseUrl + "/api/UpdatePrice"
    var addOfferPrice = BaseUrl + "/api/addOffer"
    
    // MARK: ------ My Unit End Point ------
    
    var myUnits = BaseUrl + "/api/myunits"
    var myUnitsReservation = BaseUrl + "/api/UnitReservations"
    
    var unitOfferPrice = BaseUrl + "/api/UnitsOffers"
    var unitCoupon = BaseUrl + "/api/UnitCopoun"
    var addCoupon = BaseUrl + "/api/addCopoun"
}
