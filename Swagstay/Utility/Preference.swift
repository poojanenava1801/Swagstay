
import Foundation
import SwiftyJSON

class Preference
{
    static let shared: Preference = Preference()
    let defaults = UserDefaults.standard
    
   
    
    
    
    func setGoPaymentPage(constant:String)
    {
        defaults.setValue(constant, forKey: DefaultKeys.showPaymentPage)
        defaults.synchronize()
    }
    func getGoPaymentPage()->String?{
        if let constant = defaults.object(forKey:DefaultKeys.showPaymentPage) as? String{
            return constant
        }else{
            return nil
        }
    }
    
    
//    func setDefaultSport(sport:String)
//    {
//        defaults.setValue(sport, forKey: DefaultKeys.defaultSport)
//        defaults.synchronize()
//    }
//    func getDefaultSport()->String?{
//        if let token = defaults.object(forKey:DefaultKeys.defaultSport) as? String{
//            return token
//        }else{
//            return nil
//        }
//    }
    
    func setDefaultIndex(index:Int)
    {
        defaults.setValue(index, forKey: DefaultKeys.defaultIndex)
        defaults.synchronize()
    }
    func getDefaultIndex()->IndexPath?{
        if let token = defaults.object(forKey:DefaultKeys.defaultIndex) as? Int{
            return IndexPath(row: token, section: 0)
        }else{
            return nil
        }
    }
    
//    func enableAuthenticationWithTouchID() -> Bool {
//        let (userid, password) = getUserIDAndPasswordWithTouchID()
//        if userid == nil || password == nil {
//            return false
//        }
//        return BioMetricAuthenticator.canAuthenticate()
//    }
    
    func saveUserIDAndPasswordWithTouchID(userId: String, password: String) {
        defaults.set(userId, forKey: DefaultKeys.loginUserId)
        defaults.set(password, forKey: DefaultKeys.loginPassword)
        defaults.synchronize()
    }
    func getUserIDAndPasswordWithTouchID() -> (String?, String?) {
        let userid = defaults.string(forKey: DefaultKeys.loginUserId)
        let password = defaults.string(forKey: DefaultKeys.loginPassword)
        return (userid, password)
    }
    
    func saveFreeTrialNoti(status:String) {
        defaults.set(status, forKey: DefaultKeys.freeTrialNoti)
        defaults.synchronize()
    }
    
    func getFreeTrialNoti() -> String? {
        let userid = defaults.string(forKey: DefaultKeys.freeTrialNoti)
        return userid
    }
    
    func removeFreeTrialNoti() {
        defaults.removeObject(forKey: DefaultKeys.freeTrialNoti)
        defaults.synchronize()
    }
    
    func clearUserIDAndPasswordWithTouchID() {
        defaults.set(nil, forKey: DefaultKeys.loginUserId)
        defaults.set(nil, forKey:  DefaultKeys.loginPassword)
        defaults.synchronize()
    }
    
    func clearData() {
        defaults.removeObject(forKey: DefaultKeys.user)
        defaults.removeObject(forKey: DefaultKeys.authToken)
        defaults.removeObject(forKey: DefaultKeys.userId)
        defaults.removeObject(forKey: DefaultKeys.walletAmount)
        
       // defaults.removeObject(forKey: DefaultKeys.user)
        //   defaults.removeObject(forKey: DefaultKeys.userId)
        defaults.synchronize()
    }
    
    
    func clearUserData()
    {
        defaults.removeObject(forKey: DefaultKeys.user)
        defaults.synchronize()
    }
    
    func clearshowPaymentPage()
    {
        defaults.removeObject(forKey: DefaultKeys.showPaymentPage)
        defaults.synchronize()
    }
    
    //for adjust
    func setInitialTab(InitialTab:String)
    {
        defaults.setValue(InitialTab, forKey: DefaultKeys.InitialTab)
        defaults.synchronize()
    }
    func getInitialTab()->String?{
        if let InitialTab = defaults.object(forKey:DefaultKeys.InitialTab) as? String{
            return InitialTab
        }else{
            return nil
        }
    }
    
    
    
    func setUserFCMToken(token:String)
    {
        defaults.setValue(token, forKey: DefaultKeys.authToken)
        defaults.synchronize()
    }
    func getUserFCMToken()->String?{
        if let token = defaults.object(forKey:DefaultKeys.authToken) as? String{
            return token
        }else{
            return nil
        }
    }
    
    func setUserDetails(data:JSON)
    {
        if let user = data.dictionaryObject
        {
            defaults.setValue(user.nullKeyRemoval(), forKey: DefaultKeys.user)
            defaults.synchronize()
        }
    }
    func getUserDetails()->JSON?
    {
        if let data = defaults.value(forKey: DefaultKeys.user) as? [String:Any]
        {
            let d = JSON(data)
            return d
        }else{
            return nil
        }
    }
    
    func setUserLocationDetails(data:JSON)
    {
        if let user = data.dictionaryObject
        {
            defaults.setValue(user.nullKeyRemoval(), forKey: DefaultKeys.userLocation)
            defaults.synchronize()
        }
    }
    func getUserLocationDetails()->JSON?
    {
        if let data = defaults.value(forKey: DefaultKeys.userLocation) as? [String:Any]
        {
            let d = JSON(data)
            return d
        }else{
            return nil
        }
    }
    
    func setUserCdId(id:Int)
    {
        defaults.setValue(id, forKey: DefaultKeys.userId)
        defaults.synchronize()
    }
    func getUserCdId()->Int?
    {
        if let id = defaults.value(forKey: DefaultKeys.userId) as? Int{
            return id
        }else{
            return nil
        }
    }
    
    func setWalletAmount(sport:String)
    {
        defaults.setValue(sport, forKey: DefaultKeys.walletAmount)
        defaults.synchronize()
    }
    func getWalletAmount()->String?{
        if let token = defaults.object(forKey:DefaultKeys.walletAmount) as? String{
            return token
        }else{
            return nil
        }
    }
    
}

