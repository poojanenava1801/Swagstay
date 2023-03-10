
import Foundation

struct AppUrl {

    private struct Domains {
        static let Dev = ""
        static let Live = "https://www.swagstay.com"
        static let UAT = ""
        static let Local = ""
        static let QA = ""
    }
    private  struct Routes {
       static let Api = "/Android/"
    }

    private  static let Domain = Domains.Live
    private  static let Route = Routes.Api
    private  static let BaseURL = Domain + Route
    
    static var cityImageUrl: String {
        return Domain + "//assets/images/city_image/"
    }
    static var hotelImageUrl: String {
        return Domain + "//assets/images/hotel_image/"
    }

    static var getOtp: String {
        return BaseURL  + "login_user"
    }
    
    static var bookingAll: String {
        return BaseURL  + "booking_all"
    }
    
    static var frontDashboard: String {
        return BaseURL  + "front_dashboard"
    }

    static var searchHotelAll: String {
        return BaseURL  + "search_hotel_all"
    }
    
    static var searchHotelNew: String {
        return BaseURL  + "hotel_search_new"
    }
    
    static var hotelDetails: String {
        return BaseURL  + "hotel_details"
    }
    
    static var promocodeAll: String {
        return BaseURL  + "promocode_all"
    }
    static var cancellationPolicy: String {
        return BaseURL  + "cancellationpolicy"
    }
//    static var AppShareLink: String {
//        return BaseURL  + "https://www.KingPin.pro/ios"
//    }
    static var bookingDetailsAll: String {
        return BaseURL  + "booking_details_all"
    }
   
    static var cancelBooking: String {
        return BaseURL  + "cancel_booking"
    }
    
    static var nearbyhotel: String {
        return BaseURL  + "nearbyhotel"
    }
    
    static var updateGuestName: String {
        return BaseURL  + "update_guest_name"
    }
    
    static var offersList: String {
        return BaseURL  + "offers_list"
    }
    
    static var reviewratingHotel: String {
        return BaseURL  + "reviewrating_hotel"
    }
    
    static var promocodeOrderUser: String {
        return BaseURL  + "promocode_order_user"
    }
    
    static var profileDataUrl: String {
        return BaseURL  + "profile_data_url"
    }
    
    static var updateProfileUrl: String {
        return BaseURL  + "update_profile_url"
    }
    
//    static func GetKingpinDetail(id:String) -> String{
//        return BaseURL +  "user-stats/\(id)"
//    }
    
    static var updateGstUrl: String {
        return BaseURL  + "update_gst_url"
    }
    static var walletDetails: String {
        return BaseURL  + "wallet_details"
    }
  
    
//    static func UserDetail(id:String) -> String{
//        return BaseURL +  "userdetail/\(id)"
//    }
    
    static var walletDetailsAll: String {
        return BaseURL  + "wallet_details_all"
    }
    
    static var addAmountWallet: String {
        return BaseURL  + "add_amount_wallet"
    }
    static var addAmountWalletFinal: String {
        return BaseURL  + "add_amount_wallet_final"
    }
    
    static var favoriteDetailsAll: String {
        return BaseURL  + "favorite_details_all"
    }
    
    static var addRemoveFavoriteHotel: String {
        return BaseURL  + "add_remove_favorite_hotel"
    }
    
    static var viewNotification: String {
        return BaseURL  + "view_notification"
    }
    
    static var privacyLink: String {
        return BaseURL  + "privacy_link"
    }
//    static var FollowUrl: String {
//        return BaseURL  + "only_follow_authenticated"
//    }
//    static var UpdateProfile: String {
//        return BaseURL  + "update_profile_authenticated"
//    }
//    static var ClearBetHistory: String {
//        return BaseURL  + "clear_bet_history_authenticated"
//    }
//    static var GetRealAccountBalance: String {
//        return BaseURL  + "real-account-balance/"
//    }
    
//    static func GetRealAccountBalance(id:String) -> String{
//        return BaseURL +  "real-account-balance/\(id)"
//    }
//    static func GetArticleDetail(slug:String) -> String{
//        return BaseURL + "get-articles/" + "\(slug)"
//    }
//
//    static var AddMetric: String {
//        return BaseURL  + "add-metrics"
//    }
//    static var GetPaymentHistory: String {
//        return BaseURL  + "payment-history/"
//    }
//    static var FacebookSignInUrl: String {
//        return BaseURL  + "social_login_authenticated"
//    }
//    static var GetAppUrl: String {
//        return  "https://itunes.apple.com/us/app/kingpin-pro-sports-picks/id1390339038?mt=8"
//    }
//    static var GetArticles: String {
//        return BaseURL  + "get-articles"
//    }
    
//
//    static func OTPDetails(OTP:String) -> String{
//
//        return BaseURL + "verify-code/" + "\(OTP)"
//    }
//
//    static func GetarticleDetail(slug:String,sportsName:String,membership:Int) -> String{
//
//        return Domain + "/\(sportsName)/" +  "articles/" + "\(slug)" + "?header=false" + "&membership=\(membership)"
//
//    }
//
//    static var GetNewPaymentPage: String {
//        return "https://itunes.apple.com/us/rss/customerreviews/id=1390339038/sortBy=mostRecent/json"
//    }
//    static var imageURl: String {
//        return "https:/"
//    }
}

//struct SocketUrl {
//
//    private struct SocketDomains {
//        static let Dev = Domain + ":8000/"
//        static let Live = Domain + ":5000/"
//    }
//
//    private struct Domains {
//        static let Dev = "https://kingpin.pro"
//        static let Live = "https://kingpin.pro"
//    }
//
//    private  struct Routes {
//       static let Api = "/api/"
//    }
//
//    //Socket Apis
//#if DEBUG
//    private  static let SDomain = SocketDomains.Live
//#else
//    private  static let SDomain = SocketDomains.Live
//#endif
//
//    //Apis
//    private  static let Domain = Domains.Live
//    private  static let Route = Routes.Api
//    private  static let BaseURL = Domain + Route
//
//
//    static var GET_SOCKET_URL: String {
//        return SDomain
//    }
//
//    static var GetChatBySport: String {
//        return SDomain == SocketDomains.Dev ? BaseURL + "get-sport-chat-test": BaseURL + "get-sport-chat"
//    }
//
//    static var GetChatByTeam: String {
//        return SDomain == SocketDomains.Dev ? BaseURL + "get-chat-data-test": BaseURL + "get-chat-data"
//    }
//
//    static func GetChatByUser(id:String)->String {
//        return SDomain == SocketDomains.Dev ? BaseURL + "get-user-messages-test/\(id)": BaseURL + "get-user-messages/\(id)"
//    }
//
//    static var GetMsgReplys: String {
//        return SDomain == SocketDomains.Dev ? BaseURL + "get-message-replies-test/": BaseURL + "get-message-replies/"
//    }
//}

