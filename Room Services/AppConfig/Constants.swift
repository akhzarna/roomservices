//
//  Constants.swift
//  AssemblyAugmentation
//
//  Created by Akhzar Nazir on 22/07/2019.
//  Copyright © 2019 letlechnologies. All rights reserved.
//

import Foundation

import UIKit
import Foundation

struct Constants {
    
    struct ServerConfig {
        
        // JSBL QA Server
    static let BASE_URLPHP = "https://roomserviceq8.com/wp-api.php"
    static let BASE_URLV3 = "https://roomserviceq8.com/wp-json/wc/v3/"
    static let Brands_Api = "https://roomserviceq8.com/wp-api.php?action=brands"
    static let Product_CategoriesApi = "https://roomserviceq8.com/wp-json/wc/v3/products/"
    static let IMAGE_URL = "http://jsmbqa.inov8.com.pk/i8Microbank/"
        
        // JSBL Staging Server
        //        static let BASE_URL = "http://jsmbstg.inov8.com.pk/i8Microbank/allpay.me"
        //        static let IMAGE_URL = "http://jsmbstg.inov8.com.pk/i8Microbank/"
        
    }
    
    struct ApiKeys {
        static let consumerKey = "ck_ac2f5e9b3e70a5b774612f646eb4759570a66657"
        static let consumerSecret = "cs_3fa3b2e69a012fa99d42f717aee4be72052dbd84"
    }
    
    struct Validation {
        struct Login {
            static let PASSWORD_MIN = 8
            static let PASSWORD_MAX = 15
        }
        struct TextField {
            static let AMOUNT_MIN = 10
            static let AMOUNT_MAX = 9999999
            static let MIN_CONSUMER_LEN = 1
            static let MAX_CONSUMER_LEN = 30
            static let JSBANK_MIN_LENGHT = 6
            static let JSBANK_MAX_LENGHT = 24
        }
    }
    
    struct AppConfig {
        static let IS_MOCK = 0  //0 = OFF & 1 = ON
        static let APP_VERSION = "1.0.0.0"
        
        static let DTID_KEY = "5"
        static let ENCT_KEY = "1"
        static let ACCTYPE = "1"
        static let APP_SESSION = 300
        static let HTTP_REQUEST_TIMEOUT: Double = 300
    }
    
    struct ErrorCode {
        
        static let APP_SESSION_EXPIRE_ERROR = "9050"
        static let SESSION_EXPIRE = "9007"
        static let USER_DEACTIVATE_ERROR = "9111"
        static let ALREADY_LOGGED_IN = "9066"
        static let CREDENTIAL_EXPIRE_ERROR = "9015"
        static let TERMINATE_TRANSACTION_ERROR = "9999"
        static let APP_VERSION_ERROR = "9009"
        static let OTP_SENT_ERROR_CODE = "9014"
        static let DEVICE_UPDATE_ERROR_CODE = "9017"
        static let OTP_EXPIRED_ERROR_CODE = "9020"
        static let INVALID_OTP_ERROR_CODE = "9019"
        static let RESEND_OTP_ERROR_CODE  = "9016"
        static let REGEN_OTP_ERROR_CODE   = "9015"
        static let TO_FIRST_SCREEN = "9018";
        static let INVALID_PASSWORD = "9008"
    }
    
    struct UI{
        struct Button {
            static let CORNER_RADIUS = CGFloat(2)
            
        }
        
        struct TextField {
            static let CORNER_RADIUS = CGFloat(2)
            static let BORDER_COLOR = UIColor(red:0.67, green:0.67, blue:0.67, alpha:1.0).cgColor
            static let BORDER_WIDTH = CGFloat(0.7)
            static let ACCEPTABLE_NUMERIC = "0123456789"
            static let ACCEPTABLE_ALPHANUMERIC = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"
            static let ACCEPTABLE_ALPHABETS = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
            static let MOBILE_INPUT_LENGTH = 11
            static let AMOUNT_INPUT_LENGTH = 7
            static let PIN_INPUT_LENGTH = 1
            static let CARD_INPUT_LENGTH = 4
        }
    }
    
    //Qr Code
    struct QRCode_ID{
        
        static let QR_PAN_TAG_OLD                  =   "00"
        static let QR_MERCHANT_MOBILE_NO_OLD       =  "01"
        static let QR_MERCHANT_NAME_TAG_OLD        =   "0A"
        static let QR_MERCHANT_CATEGORY_TAG_OLD    =   "0B"
        static let QR_MERCHANT_CITY_TAG_OLD        =   "0C"
        
    }
    
    struct Message {
        
        
        
        static let IN_APP_PURCHASE_MESSAGE = "in-App purchase not available yet"
        static let APP_DOWNLOAD_URL = "https://itunes.apple.com/app/js-mobile-banking/id1440565349"
        static let ALERT_SUCCESS_MESSAGE = "Successful message"
        static let ALERT_SUCCESS_TITLE = "Transaction Successful"
        static let ALERT_NOTIFICATION_TITLE = "Alert Notification"
        
        static let UPDATE_APP = "Please update your application"
        
        static let UNKNOWN_SERVER_ERROR = "We are unable to process your request at the moment. Please try again later."
        
        static let GENERAL_SERVER_ERROR = "Connection with the server cannot be established at this time. Please try again or contact your service provider."
        
        //static let EXCEPTION_GENERIC = "Your session has expired. Please try again."
        
        static let EXCEPTION_TIME_OUT = "This seems to be taking longer than usual. Please try again later."
        
        static let EXCEPTION_HTTP_UNAVAILABLE = "Service unavailable due to technical difficulties. Please try again or contact service provider."
        
        static let SESSION_TIMEOUT = "Session has expired. Please login again."
        
        static let CONNECTIVITY_ISSUE = "There is no or poor internet connection. Please connect to stable internet connection and try again."
        
    }
    
    struct HTTPStatusCode {
        static let SUCCESS = 200
        static let NOT_FOUND = 404
        static let SERVICE_UNAVAILABLE = 503
        static let GATEWAY_TIMEOUT = 504
    }
    
    struct DEVICEFAMILY {
        
        static let   IS_IPAD = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad
        static let IS_IPHONE = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.phone
        
    }
    
    struct ScreenSize
    {
        static let SCREEN_WIDTH = UIScreen.main.bounds.size.width
        static let SCREEN_HEIGHT = UIScreen.main.bounds.size.height
        static let SCREEN_MAX_LENGTH = max(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
        static let SCREEN_MIN_LENGTH = min(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
    }
    
    struct DeviceType
    {
        static let IS_IPHONE_4_OR_LESS =  UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH < 568.0
        static let IS_IPHONE_5 = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 568.0
        static let IS_IPHONE_6 = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 667.0
        static let IS_IPHONE_6P = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 736.0
        static let IS_IPHONE_X = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH >= 812.0
    }
    
}
