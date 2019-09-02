//
//  DatabaseHelper.swift
//  WatchHorseTv
//  Created by tahir hameed on 25/06/2019.



import UIKit
import FMDB

let databaseHelperInstance  = DatabaseHelper()

class DatabaseHelper: NSObject {

    var documentsDirectory: String = ""
    var databaseFilename: String = ""
    var arrResults:NSArray = NSArray()
   
    var database: FMDatabase = FMDatabase()
    
    class func getInstance() -> DatabaseHelper
    {
        //print(Util.getFilePath(fileName: "/SharkId1.sqlite"))
        if (databaseHelperInstance.database.databasePath == nil) {
            databaseHelperInstance.database = FMDatabase(path: Util.getFilePath(fileName: "/RoomServices.sqlite"))
            //databaseHelperInstance.database.openNew()
        }
       // databaseHelperInstance.database = FMDatabase(path: Util.getFilePath(fileName: "/SharkId1.sqlite"))
        return databaseHelperInstance
    }

    override init() {
        
    }
//    init(databaseFilename dbFilename: String) {
//        super.init()
//        self.documentsDirectory = Util.getFilePath(fileName: "/Watchhorse.db")
//        print(Util.getFilePath(fileName: "/Watchhorse.db"))
//        self.databaseFilename = dbFilename
//        self.copyDatabaseIntoDocumentsDirectory()
//    }
    
//    func copyDatabaseIntoDocumentsDirectory() {
//
//        let fileManager = FileManager.default
//        let documentsPath = NSURL(fileURLWithPath: NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0])
//        print("document path",documentsPath)
//        let destinationSqliteURL = documentsPath.appendingPathComponent("Watchhorse.db")
//        let sourceSqliteURL = Bundle.main.url(forResource: "Watchhorse", withExtension: "db")
    init(databaseFilename dbFilename: String) {
        super.init()
        self.documentsDirectory = Util.getFilePath(fileName: "/RoomServices.sqlite")
        print("Data Base Path",Util.getFilePath(fileName: "/RoomServices.sqlite"))
        self.databaseFilename = dbFilename
        self.copyDatabaseIntoDocumentsDirectory()
    }
    
    func copyDatabaseIntoDocumentsDirectory() {
        
//        let fileManager = FileManager.default
//        let documentsPath = NSURL(fileURLWithPath: NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0])
//        print("document path",documentsPath)
//        let destinationSqliteURL = documentsPath.appendingPathComponent("Lynkworld.sqlite")
//        let sourceSqliteURL = Bundle.main.url(forResource: "Lynkworld", withExtension: "sqlite")
//
//        if !FileManager.default.fileExists(atPath: destinationSqliteURL!.path) {
//            // var error:NSError? = nil
//            do {
//                try fileManager.copyItem(at: sourceSqliteURL!, to: destinationSqliteURL!)
//            } catch let error as NSError {
//                print("Unable to create database \(error.debugDescription)")
//            }
//        }
//    }
        let fileManager = FileManager.default
        
        let documentsUrl = fileManager.urls(for: .documentDirectory,
                                            in: .userDomainMask)
        
        guard documentsUrl.count != 0 else {
            return // Could not find documents URL
        }
        
        let finalDatabaseURL = documentsUrl.first!.appendingPathComponent("RoomServices.sqlite")
        
        if !( (try? finalDatabaseURL.checkResourceIsReachable()) ?? false) {
            print("DB does not exist in documents folder")
            
            let documentsURL = Bundle.main.resourceURL?.appendingPathComponent("RoomServices.sqlite")
            
            do {
                try fileManager.copyItem(atPath: (documentsURL?.path)!, toPath: finalDatabaseURL.path)
            } catch let error as NSError {
                print("Couldn't copy file to final location! Error:\(error.description)")
            }
            
        } else {
            print("Database file found at path: \(finalDatabaseURL.path)")
        }

    }
    
    func executeInsertQuery(aStrQuery: String) -> Bool {
        
        print(aStrQuery)
        var isSuccess  = true
        DatabaseHelper.getInstance().database.open()
        print(databaseHelperInstance)
        isSuccess = database.executeUpdate(aStrQuery, withArgumentsIn:[])
         DatabaseHelper.getInstance().database.close()
        
        return isSuccess
    }
    func getdataFromQueryNew(aStrQuery: String) -> [AnyObject] {
        
        let arrData: NSMutableArray = NSMutableArray()
        var resultSet : FMResultSet! = FMResultSet()
        DatabaseHelper.getInstance().database.open()
        self.database.beginTransaction()
        resultSet = database.executeQuery(aStrQuery, withArgumentsIn: [])
        
        if (resultSet != nil) {
            
            while resultSet.next() {
                let rowdata : NSMutableDictionary = NSMutableDictionary()
                for i in 0..<resultSet.columnCount {
                    rowdata.setValue(resultSet.string(forColumn:resultSet.columnName(for: Int32(i))!), forKey:resultSet.columnName(for: Int32(i))!)
                }
                arrData.add(rowdata)
            }
        }
        else{
            print(self.database.lastErrorMessage())
        }
        
        self.database.commit()
        DatabaseHelper.getInstance().database.close()
        return arrData as [AnyObject]
        
    }
    func executeInsertQueryWithBulk(aStrQuery: String) -> Bool {
        DatabaseHelper.getInstance().database.open()
        var isSuccess  = true
        isSuccess = database.executeUpdate(aStrQuery, withArgumentsIn:[])
        DatabaseHelper.getInstance().database.close()
        return isSuccess
    }
    
    func getAllDocuments() {
        
    }
    
        func insertVideoData(array:[[String: Any]]) {
            var price : Float = 0.0
            var smUrl : String = ""
            var videoUrl : String = ""
            var videoId : Int = 0
            let addToCart: Int = 0
            
           // insert into Horses (competitionLocation,dateUtc,competitionName,riderName,horseName,price,smUrl,mdUrl,lgUrl,createdUtc,horse,sku,videoURL, addtocart)
            for aDictDetail in array {
                
                if let avideoId = aDictDetail["videoId"] as? Int{
                    videoId = avideoId
                }
                let aCompetition = aDictDetail["competition"] as? NSDictionary
                let aRider = aDictDetail["rider"] as? NSDictionary
                if let aprice = aDictDetail["price"] as? Float{
                    price = aprice
                }
                if let asmUrl = aDictDetail["smUrl"] as? String{
                    smUrl = asmUrl
                }
                if let avideoUrl = aDictDetail["videoUrl"] as? String{
                    videoUrl = avideoUrl
                }
                
    let aStrInsertQuery = String(format:"INSERT INTO videos (competitionLocation,dateUtc,sku,createdUtc,riderName,horseName,competitionName,price,smUrl,videoUrl,videoId,addToCart) VALUES (\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\")",aCompetition!["location"] as!
        String,aCompetition!["dateUtc"] as!
        String, aDictDetail["sku"] as!
        String,aDictDetail["createdUtc"] as!
        String,aRider!["name"] as!
        String, aDictDetail["horseName"] as!
        String,aCompetition!["name"] as!
        String,String(price),String(smUrl),String(videoUrl),String(videoId),String(addToCart)) as CVarArg
                let isSuccess = executeInsertQuery(aStrQuery: aStrInsertQuery as! String)
                print("success",isSuccess)
                
            }
        }
    
    
    func getCartItemList() -> [[String: Any]] {
        let aStrUpdateQuery = String(format:"SELECT * FROM cart")
        let arrdata:[[String: Any]] = getdataFromQueryNew(aStrQuery: aStrUpdateQuery) as! [[String: Any]]
        return arrdata
    }
    
    func deleteCartItem(byVideoId videoId: Int) -> [[String: Any]] {
        let aStrUpdateQuery = String(format:"DELETE FROM cart WHERE id = %d",videoId)
        let arrdata:[[String: Any]] = getdataFromQueryNew(aStrQuery: aStrUpdateQuery) as! [[String: Any]]
        let isSuccess = executeInsertQuery(aStrQuery: aStrUpdateQuery as! String)
        print("success",isSuccess)
        return arrdata
    }
    
    func insertIntoCart(array: AllProducts, quantity: Int) {
         print(array, quantity)
        DispatchQueue.main.async {
       // for object in array {
            let aStrInsertQuery = String(format:"INSERT INTO cart (id,name,image,description,price,display,quantity,short_description,menu_order) VALUES (\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%d\",\"%@\",\"%d\")",array.id,array.name,array.image,array.description,array.price,array.display,quantity,array.short_description,array.menu_order)
            
            
            print(aStrInsertQuery)
    
            let isSuccess = self.executeInsertQuery(aStrQuery: aStrInsertQuery )
            print("success",isSuccess)
      //  }
    }
}
    
    
    
    func getCartList() -> NSObject {
            let aStrUpdateQuery = String(format:"SELECT * FROM cart")
        let arrdata:NSObject = getdataFromQueryNew(aStrQuery: aStrUpdateQuery) as NSObject
            return arrdata
    }
    func getVidoesList(byVideoAddCart addToCart:Int) -> [[String: Any]] {
        let aStrUpdateQuery = String(format:"SELECT sku, price,smUrl FROM videos WHERE addToCart='1' UNION SELECT sku, price,smUrl FROM photos WHERE addToCart='1'")
        let arrdata:[[String: Any]] = getdataFromQueryNew(aStrQuery: aStrUpdateQuery) as! [[String: Any]]
        return arrdata
    }
    
    
    func getFromVideosAndPhotosList() -> [[String: Any]] {
        let aStrUpdateQuery = String(format:"SELECT * FROM photos")
        let arrdata:[[String: Any]] = getdataFromQueryNew(aStrQuery: aStrUpdateQuery) as! [[String: Any]]
        return arrdata
    }
    
    
    func updateQuantityIdForAddtoCart(productId ProId: String, quantity: Int) {
            print(ProId,quantity)
        let aStrUpdateQuery = String(format:"UPDATE cart SET quantity = %d WHERE  id = %@",quantity,ProId)
        let isSuccess = executeInsertQuery(aStrQuery: aStrUpdateQuery)
        print("Update success",isSuccess)
    }
    func updateByPhotoIdForAddtoCart(byPhotoId photoId: Int) {
        
        let aStrUpdateQuery = String(format:"UPDATE photos SET addToCart = '1' WHERE  photoId = %d",photoId)
        let isSuccess = executeInsertQuery(aStrQuery: aStrUpdateQuery)
        print("Update success",isSuccess)
    }
    
    func updateByVideoIdForRemovefromCart(byVideoId videoId: Int) {
        
        let aStrUpdateQuery = String(format:"UPDATE videos SET addToCart = '0' WHERE  videoId = %d",videoId)
        let isSuccess = executeInsertQuery(aStrQuery: aStrUpdateQuery)
        print("Update success",isSuccess)
    }
    
//    func manageUserDetail(withUser user: User) {
//
//        let arrDetails = getuserDetails(filterByUserID: user.userID)
//        if arrDetails.count > 0 {
//            updateUserDetails(byUser: user)
//        } else {
//            insertUserDetails(byUser: user)
//        }
//        manageExperiances(by: user.experiance)
//        manageEducation(by: user.education)
//    }
//    func getuserDetails(filterByUserID user: String) -> NSArray {
//        let aStrUpdateQuery = String(format:"SELECT * FROM UserMaster WHERE userID = '%@'", user)
//        let arrdata:NSArray = getdataFromQueryNew(aStrQuery: aStrUpdateQuery) as NSArray
//        return arrdata
//    }
//    func insertUserDetails(byUser user: User) {
//
//         let aStrInsertQuery = String(format:"INSERT INTO UserMaster (userID , name , image , poster,headline,currentPosition,education,state,city,country,location,industry,languageName,languageID,aboutYou) VALUES (\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\")",user.userID, user.name,user.profileImageURL,user.coverImageURL,user.headline,"","",user.state,user.city,user.country,user.location,user.industry,user.language,user.language,user.aboutMe) as CVarArg
//        let isSuccess = executeInsertQuery(aStrQuery: aStrInsertQuery as! String)
//        print("success",isSuccess)
//    }
//
//    func updateUserDetails(byUser user: User) {
//
//
//        let aStrUpdateQuery = String(format:"UPDATE UserMaster SET name = \"%@\" , image  = \"%@\" , poster  = \"%@\" ,headline = \"%@\", currentPosition = \"%@\" , education = \"%@\" , country = \"%@\" , state = \"%@\" ,city = \"%@\", industry = \"%@\" , languageName = \"%@\" ,aboutYou = \"%@\"  WHERE  userID = '%@'",user.name,user.profileImageURL, user.coverImageURL, user.headline, "", "", user.country, user.state, user.city, user.industry, user.language, user.aboutMe, user.userID)
//        let isSuccess = executeInsertQuery(aStrQuery: aStrUpdateQuery)
//        print("Update success",isSuccess)
//    }
//
//
//    func manageExperiances(by experiances: [Experiance]) {
//        for experiance in experiances {
//            let arrData = getexperianceDetails(filterByexperianceID: experiance.expID)
//            if arrData.count > 0 {
//                updateExperianceDetail(byExperiance: experiance)
//            } else {
//                insertExperienceData(experiance: experiance)
//            }
//        }
//    }
//    func getexperianceDetails(filterByexperianceID expID: String) -> NSArray {
//        let aStrUpdateQuery = String(format:"SELECT * FROM ExperienceManager WHERE experianceID = '%@'", expID)
//        let arrdata:NSArray = getdataFromQueryNew(aStrQuery: aStrUpdateQuery) as NSArray
//        return arrdata
//    }
//
//
//    func insertExperienceData(experiance: Experiance)
//    {
//        let aStrInsertQuery = String(format:"INSERT INTO ExperienceManager (experianceID, position , companyName , localAdress ,description, fromMonth , fromYear , toMonth , toYear ,isCurrentlyWorking, userID) VALUES (\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",%d,\"%@\")",experiance.expID ,experiance.title,experiance.companyName , experiance.address, experiance.detailDescription, experiance.fromMonth ,experiance.fromYear, experiance.toMonth, experiance.toYear, NSNumber(value: experiance.currentCompany), experiance.userID) as CVarArg
//        let isSuccess = executeInsertQuery(aStrQuery: aStrInsertQuery as! String)
//        print("success",isSuccess)
//
//    }
//
//    func updateExperianceDetail(byExperiance experiance: Experiance) {
//
//
//        let aStrUpdateQuery = String(format:"UPDATE ExperienceManager SET position = \"%@\" , companyName  = \"%@\" , localAdress  = \"%@\" ,description = \"%@\", fromMonth = \"%@\" , fromYear = \"%@\" , toMonth = \"%@\" , toYear = \"%@\" ,isCurrentlyWorking = %d WHERE  experianceID = '%@'",experiance.title,experiance.companyName , experiance.address, experiance.detailDescription, experiance.fromMonth ,experiance.fromYear, experiance.toMonth, experiance.toYear, NSNumber(value: experiance.currentCompany),experiance.expID)
//        let isSuccess = executeInsertQuery(aStrQuery: aStrUpdateQuery)
//        print("Update success",isSuccess)
//    }
//
//    func manageEducation(by educations: [Education]) {
//        for education in educations {
//            let arrData = geteducationDetails(filterByeducatinID: education.eduID)
//            if arrData.count > 0 {
//                updateEducationData(byEducation: education)
//            } else {
//                insertEducationData(byEducation: education)
//            }
//        }
//    }
//    func geteducationDetails(filterByeducatinID eduID: String) -> NSArray {
//        let aStrUpdateQuery = String(format:"SELECT * FROM EducationManager WHERE educationID = '%@'", eduID)
//        let arrdata:NSArray = getdataFromQueryNew(aStrQuery: aStrUpdateQuery) as NSArray
//        return arrdata
//    }
//
//    func insertEducationData(byEducation education: Education) {
//
//        let aStrInsertQuery = String(format:"INSERT INTO EducationManager (educationID , schoolName , degreeName , studyField , grade , fromYear , toYear , description , userID) VALUES (\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\")",education.eduID ,education.school,education.degree, education.studyField,education.grade,education.fromYear ,education.toYear,education.detailDescription,education.userID) as CVarArg
//        let isSuccess = executeInsertQuery(aStrQuery: aStrInsertQuery as! String)
//        print("success",isSuccess)
//
//    }
//    func updateEducationData(byEducation education: Education) {
//        let aStrUpdateQuery = String(format:"UPDATE EducationManager SET schoolName  = \"%@\" , degreeName  = \"%@\" ,studyField = \"%@\", grade = \"%@\" , fromYear = \"%@\" , toYear = \"%@\" , description = \"%@\"  WHERE  educationID = '%@'",education.school,education.degree, education.studyField,education.grade,education.fromYear ,education.toYear,education.detailDescription,education.eduID)
//        let isSuccess = executeInsertQuery(aStrQuery: aStrUpdateQuery)
//        print("Update success",isSuccess)
//    }
//
//
//
//
//    func getEducationDetails(filterByUserID userID: String) -> NSArray {
//        let aStrUpdateQuery = String(format:"SELECT * FROM EducationManager WHERE userID = '%@'", userID)
//        let arrdata:NSArray = getdataFromQueryNew(aStrQuery: aStrUpdateQuery) as NSArray
//        return arrdata
//    }
//
//
//    //Mark:- insert userdata
//    func insertUserData(aDictDetail:NSDictionary, aStrUserID : String) {
//        let aStrInsertQuery = String(format:"INSERT INTO UserMaster (userID , name , image , poster , headline , currentPosition , education , country , state, city , industry , languageName , languageID , aboutYou ) VALUES (\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\")",aDictDetail["userID"] as! String , aDictDetail["name"] as! String,aDictDetail["image"] as! String, aDictDetail["poster"] as! String, aDictDetail["headline"] as! String, aDictDetail["currentposition"] as! String, aDictDetail["education"] as! String, aDictDetail["country"] as! String, aDictDetail["state"] as! String, aDictDetail["city"] as! String, aDictDetail["industry"] as! String, aDictDetail["prelangname"] as! String, aDictDetail["prelangid"] as! String, aDictDetail["about"] as! String) as CVarArg
//        let isSuccess = executeInsertQuery(aStrQuery: aStrInsertQuery as! String)
//        print("success",isSuccess)
//
//    }
//
//    //Mark:- insert verified manager data
//    func insertverifiedManagerData(aDictDetail:NSDictionary, aStrUserID : String)
//    {
//        let aStrInsertQuery = String(format:"INSERT INTO VerifiedManager (docID , userID , comment) VALUES (\"%@\",\"%@\",\"%@\")",aDictDetail["docID"]as! String ,aDictDetail["userID"]as! String,aDictDetail["comment"]as! String) as CVarArg
//        let isSuccess = executeInsertQuery(aStrQuery: aStrInsertQuery as! String)
//        print("success",isSuccess)
//
//    }
//
//    //Mark:- insert Education
//    func insertEducationData(aDictDetail:NSDictionary, aStrUserID : String)
//    {
//        let aStrInsertQuery = String(format:"INSERT INTO EducationManager (educationID , schoolName , degreeName , studyField , grade , fromYear , toYear , description , userID) VALUES (\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\")",aDictDetail["educationID"]as! String ,aDictDetail["schoolName"]as! String,aDictDetail["degreeName"]as! String,aDictDetail["studyField"]as! String,aDictDetail["grade"]as! String,aDictDetail["fromYear"]as! String ,aDictDetail["toYear"]as! String,aDictDetail["description"]as! String,aDictDetail["userID"]as! String) as CVarArg
//        let isSuccess = executeInsertQuery(aStrQuery: aStrInsertQuery as! String)
//        print("success",isSuccess)
//
//    }
//
//    //Mark:- insert Project
//    func insertProjectData(aDictDetail:NSDictionary, aStrUserID : String)
//    {
//        let aStrInsertQuery = String(format:"INSERT INTO Projects (projectID, name , url , desciption , fromMonth , fromYear , toMonth , toYear ,isCurrentlyWorking, userID) VALUES (\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",%d,\"%@\")",aDictDetail["projectID"]as! String ,aDictDetail["name"]as! String,aDictDetail["url"]as! String,aDictDetail["desciption"]as! String,aDictDetail["fromMonth"]as! String,aDictDetail["fromYear"]as! String ,aDictDetail["toMonth"]as! String,aDictDetail["toYear"]as! String,aDictDetail["isCurrentlyWorking"]as! Int, aDictDetail["userID"]as! String) as CVarArg
//        let isSuccess = executeInsertQuery(aStrQuery: aStrInsertQuery as! String)
//        print("success",isSuccess)
//
//    }
//
//    //Mark:- insert experience
//    func insertExperienceData(aDictDetail:NSDictionary, aStrUserID : String)
//    {
//        let aStrInsertQuery = String(format:"INSERT INTO Experience (experianceID, position , companyName , localAdress ,description, fromMonth , fromYear , toMonth , toYear ,isCurrentlyWorking, userID) VALUES (\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",%d,\"%@\")",aDictDetail["experianceID"]as! String ,aDictDetail["position"]as! String,aDictDetail["companyName"]as! String,aDictDetail["localAdress"]as! String,aDictDetail["description"]as! String,aDictDetail["fromMonth"]as! String ,aDictDetail["fromYear"]as! String,aDictDetail["toMonth"]as! String,aDictDetail["toYear"]as! String,aDictDetail["isCurrentlyWorking"]as! Int, aDictDetail["userID"]as! String) as CVarArg
//        let isSuccess = executeInsertQuery(aStrQuery: aStrInsertQuery as! String)
//        print("success",isSuccess)
//
//    }
//
//
//    //Mark:- insert Documenttype
//    func insertDocTypeMasterData(aDictDetail:NSDictionary, aStrUserID : String)
//    {
//        let aStrInsertQuery = String(format:"INSERT INTO DocTypeMaster (docTypeID , title , type) VALUES (\"%@\",\"%@\",\"%@\")",aDictDetail["docTypeID"]as! String ,aDictDetail["title"]as! String,aDictDetail["type"]as! String) as CVarArg
//        let isSuccess = executeInsertQuery(aStrQuery: aStrInsertQuery as! String)
//        print("success",isSuccess)
//
//    }
//
//    //Mark:- insert DocumentManager
//    func insertDocumentManagerData(aDictDetail:[String: Any], aStrUserID : String)
//    {
//        let aStrInsertQuery = String(format:"INSERT INTO DocManager (docID , legalName , eatherID , issueCountry , nationality , issueDate , expiryDate , birthDate , birthPlace, addressline1 , addressline2 , city , state , country, zipcode , comment , docImage , isVerified , userID , email , phone , docType, docName) VALUES (\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",%d,\"%@\",\"%@\",\"%@\",\"%@\",\"%@\")", aDictDetail["docID"] as! String, aDictDetail["legalName"] as! String, aDictDetail["etherID"] as! String, aDictDetail["issueCountry"] as! String, aDictDetail["nationality"] as! String, aDictDetail["issueDate"] as! String, aDictDetail["expiryDate"] as! String, aDictDetail["birthDate"] as! String, aDictDetail["birthPlace"] as! String, aDictDetail["address1"] as! String, aDictDetail["address2"] as! String, aDictDetail["city"] as! String, aDictDetail["state"] as! String, aDictDetail["country"] as! String, aDictDetail["zipcode"] as! String, aDictDetail["comment"] as! String, aDictDetail["docImage"] as! String, aDictDetail["isVerified"] as! Int, aDictDetail["userID"] as! String, aDictDetail["email"] as! String, aDictDetail["phone"] as! String, aDictDetail["docType"] as! String, aDictDetail["docName"] as! String) as CVarArg
//
//        let isSuccess = executeInsertQuery(aStrQuery: aStrInsertQuery as! String)
//        print("success",isSuccess)
//
//    }
//
//    func getDocuments(filterBy type: String, userID user: String) -> NSArray {
//         let aStrUpdateQuery = String(format:"SELECT * FROM DocManager WHERE docType = '%@' AND userID = '%@'", type, user)
//         let arrdata:NSArray = getdataFromQueryNew(aStrQuery: aStrUpdateQuery) as NSArray
//        return arrdata
//    }
//
//    func getDocumentsList(filterBy type: String, userID user: String) -> [[String: Any]] {
//        let aStrUpdateQuery = String(format:"SELECT * FROM DocManager WHERE docType = '%@' AND userID = '%@'", type, user)
//        let arrdata:[[String: Any]] = getdataFromQueryNew(aStrQuery: aStrUpdateQuery) as! [[String: Any]]
//        return arrdata
//    }
//
//
//
//    func updateInDocumentsManager(by dictionary: [String: Any], localDocID localID: Int) {
//
//        var strUpdates = ""
//
//        for (key, value) in dictionary {
//
//            if let val = value as? String {
//                strUpdates = "\(key) = \(val), "
//            } else if let val = value as? Int {
//                strUpdates = "\(key) = \(val), "
//            } else if let val = value as? NSNumber {
//                strUpdates = "\(key) = \(val), "
//            }
//        }
//        if strUpdates.count > 0 {
//            strUpdates = String(strUpdates.dropLast(2))
//        }
//
//        let aStrUpdateQuery = String(format:"UPDATE DocManager SET %@ WHERE localID = %d",strUpdates,localID)
//        let isSuccess = executeInsertQuery(aStrQuery: aStrUpdateQuery)
//        print("Update success",isSuccess)
//    }
//
//
//
//
//    func ListOfSmokingDate(smokingDate: String)-> NSArray {
//        let aStrUpdateQuery = String(format:"SELECT * FROM TblNotifcation WHERE notificationdate >= '%@' limit 60",smokingDate)
//        let arrdata:NSArray = getdataFromQueryNew(aStrQuery: aStrUpdateQuery) as NSArray
//
//        if (arrdata.count>0) {
//
//        }
//        return arrdata
//    }
    
   /*
    func isCheckSync(UserId:String,Is_sync:String)->Bool
    {
        let aStrUpdateQuery = String(format:"SELECT * FROM Connection_Data WHERE ToUser_ID = '%@' AND Is_Sync = '%@'",UserId,Is_sync)
        
        var isExists = false
        
        let arrdata:NSArray = getdataFromQueryNew(aStrQuery: aStrUpdateQuery) as NSArray
        
        if (arrdata.count>0) {
            isExists = true
        }
        return isExists
    }
    func Update_sync_status(UserId auserid : String,Is_Sync ais_sync:String)
    {
        let aStrUpdateQuery = String(format:"UPDATE Connection_Data SET Is_Sync = '%@' WHERE  ToUser_ID ='%@'",ais_sync,auserid)
        _ = executeInsertQuery(aStrQuery: aStrUpdateQuery)
    }
    func insertMessage(aDictDetail:NSDictionary, aStrUserID : String)
    {
        
        let aStrInsertQuery = String(format:"INSERT INTO chat_messages (message_id , content , timestamp , senderid , sender_name , sender_profile_image , receiverid , receive_name , receive_profile_image , read_flag ) VALUES (\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%d\")",aStrUserID ,aDictDetail["content"]as! String,aDictDetail["timestamp"]as! String,aDictDetail["senderid"]as! String,aDictDetail["sender_name"]as! String,aDictDetail["sender_profile_image"]as! String ,aDictDetail["receiverid"]as! String,aDictDetail["receive_name"]as! String,aDictDetail["receive_profile_image"]as! String,aDictDetail["read_flag"] as! Int) as CVarArg
        //\(aStrUserID)','\(aDictDetail["content"]as! String)','\(aDictDetail["timestamp"]as! String)','\(aDictDetail["senderid"]as! String)','\(aDictDetail["sender_name"]as! String)','\(aDictDetail["sender_profile_image"]as! String)'
        let isSuccess = executeInsertQuery(aStrQuery: aStrInsertQuery as! String)
        print("success",isSuccess)
        
    }
    //SELECT * from chat_messages LIMIT 5 OFFSET 50
    func CountMessageData(SenderID senderid : String,RecieverID receiverid:String) -> Int
    {
        var totalNumberOfRow: Int = 0
        
        databaseHelperInstance.database.open()
        
        let resultSet: FMResultSet! =  databaseHelperInstance.database.executeQuery(String(format:"SELECT count(*) AS message_id FROM chat_messages WHERE (senderid = '%@' AND receiverid = '%@') OR (senderid = '%@'AND receiverid = '%@')  ",senderid,receiverid,receiverid,senderid), withArgumentsIn: nil)
        
        if (resultSet != nil) {
            while resultSet.next() {
                
                totalNumberOfRow =  Int(resultSet.string(forColumn: "message_id"))!
                
            }
        }
        databaseHelperInstance.database.close()
        
        return totalNumberOfRow
    }
    
    func GetOwnSendMessage(SenderID senderid : String,RecieverID receiverid:String,Limit alimit:Int,Offset aoffset:Int) -> NSArray
    {
        let aStrUpdateQuery = String(format:"SELECT * FROM chat_messages WHERE (senderid = '%@' AND receiverid = '%@') OR (senderid = '%@'AND receiverid = '%@') ORDER BY message_id DESC LIMIT '%d' OFFSET '%d' ",senderid,receiverid,receiverid,senderid,alimit,aoffset)
        
        var isExists = false
        
        let arrdata:NSArray = getdataFromQueryNew(aStrQuery: aStrUpdateQuery) as NSArray
        
        if (arrdata.count>0) {
            isExists = true
        }
        return arrdata
    }
    func GetOtherSendMessage(SenderID senderid : String,RecieverID receiverid:String) -> NSArray
    {
        let aStrUpdateQuery = String(format:"SELECT * FROM chat_messages WHERE senderid = '%@'AND receiverid = '%@' AND  read_flag != '%d'",senderid,receiverid,3)
        
        var isExists = false
        
        let arrdata:NSArray = getdataFromQueryNew(aStrQuery: aStrUpdateQuery) as NSArray
        
        if (arrdata.count>0) {
            isExists = true
        }
        return arrdata
    }
    func CheckMessageId(MessageID amessageid : String) -> NSArray
    {
        let aStrUpdateQuery = String(format:"SELECT * FROM chat_messages WHERE message_id = '%@'",amessageid)
        
        var isExists = false
        
        let arrdata:NSArray = getdataFromQueryNew(aStrQuery: aStrUpdateQuery) as NSArray
        
        if (arrdata.count>0) {
            isExists = true
        }
        return arrdata
    }
    func CheckDeliverFlag(MessageID amessageid : String)->Bool
    {
        let aStrUpdateQuery = String(format:"SELECT * FROM chat_messages WHERE message_id = '%@' AND read_flag = '1'",amessageid)
        
        var isExists = false
        
        let arrdata:NSArray = getdataFromQueryNew(aStrQuery: aStrUpdateQuery) as NSArray
        
        if (arrdata.count>0) {
            isExists = true
        }
        return isExists

    }
    func updateReadFlagStatus(MessageID amessage_id : String,Read_Flag aread_flag:Int)
    {
//        DatabaseHelper.getInstance().database.open()
        let aStrUpdateQuery = String(format:"UPDATE chat_messages SET read_flag = '%d' WHERE  message_id ='%@'",aread_flag,amessage_id)
        _ = executeInsertQuery(aStrQuery: aStrUpdateQuery)
//        databaseHelperInstance.database.executeUpdate(aStrUpdateQuery, withArgumentsIn:nil)
//        DatabaseHelper.getInstance().database.close()

        
    }
    func DeleteTable(){
         _ = executeInsertQueryWithBulk(aStrQuery: "DELETE from chat_messages")
         _ = executeInsertQueryWithBulk(aStrQuery: "DELETE from Connection_Data")
      
    }
    //MARK:: Method That Get Main Number Of User
    
    */
   
  }
