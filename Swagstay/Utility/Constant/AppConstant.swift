

import Foundation
import UIKit


struct AppConstant {
    static let AppName = "Kingpin"
    static let TitleFreeTrial = "GET 7 DAYS FREE"
    static let TitleMonthly = "GET KINGPIN PRO"
    static let AppShareLink = "https://www.KingPin.pro/ios"

}


struct Config {
    static let PurchaseApiKey = "bTAxKoihvPkteaDVjwijkMNIujwHWsgV"
    static let IpAccessToken = "97d44c899514e13f88dc55a21ee2c763"
    static let OneSignalId = "df002a8f-0191-4aad-be79-b22b353de298"
    static let twitterConsumerKey = "hTpkPVU4pThkM0"
    static let twitterConsumerSecreteKey = "ovEqziMzLpUOF163Qg2mj"
    static let AdjustToken = "4v20zudzeha8"

}


struct DefaultKeys {
    static let user = "user"
    static let userLocation = "userLocation"
    static let userId = "userId"
    static let authToken = "authToken"
    static let loginUserId = "loginUserId"
    static let loginPassword = "loginPassword"
    static let walletAmount = "walletAmount"
    static let defaultIndex = "defaultIndex"
    static let freeTrialNoti = "FreeTrialNoti"

    //static let showPop = "showPop"
    static let showPaymentPage = "showPaymentPage"
    static let InitialTab = "initialTab"
}


struct ColorCode {
    static let Blue = "0259CB"
    static let NormalBlue = "063E9A"
    static let GradientBlue = "1260E6"
    static let Green = "2EDB32"
    static let NormalGreen = "59FF46"
    static let GradientGreen = "2EBD59"
    static let GreenBorder = "33E044"
    static let greenTablinear = "32D0B0"
    static let blueTabGradient = "0180FC"
    static let RestoreLight = "35D4AE"
    static let RstoreBlue = "007EFF"
    static let lightGrey = "E8E7FE"
    static let lightWhite = "FCFCFC"
    static let DropDownGrey = "626266"
    static let HighlightBlue = "325BD3"
}

struct FontName {
    static let MontserratRegular = "Montserrat-Regular"
    static let MontserratMedium = "Montserrat-Medium"
    static let MontserratBold = "Montserrat-Bold"
}

struct NotificationKey {
    static let showMyImage = "ShowMyImage"
    static let ExpertPicks = "ExpertPicks"
    static let TopBettors = "TopBettors"
    static let PlacePicks = "PlacePicks"
    static let SideMenu = "SideMenu"
    static let emptyCart = "EmptyCart"
    static let chatBadgeCount = "ChatBadgeCount"
    static let updateUpgradeButton = "UpdateUpgradeButton"

}

struct ColorNamed {
    static let kpDarkBlue =  UIColor(named: "kpDarkBlue")
}


//Static Strings
struct StaticString {
    static let InternetConnectionAlert = "Internet connection is unavailable"
    static let ServerError = "Server is busy, please try again"
    static let SomeError = "Some error from server, and its notification is already displayed to user"
    static let EmailError = "Email is incorrect."
    static let TypeMessage = "Type message here..."
    static let CharactersLeft = "Characters left: "
    static let EmailAlert = "Enter email"
    static let EmailValidationAlert = "Enter valid email"
    static let PasswordAlert = "Enter password"
    static let ConfirmPasswordAlert = "Enter Confirm password"
    static let PasswordNotMatch = "Does not match password."
    static let OTPAlert = "Enter OTP"
    static let VCodeAlert = "Enter Verification Code"

    static let OTPVerifyAlert = "Enter Correct OTP"
    static let WRONGOTP = "OTP is incorrect"
    static let OTPVerified = "Email Verified"
    static let EmailAlerts = "Please check your email or spam folder for verification code"
    
    static let UserName = "Enter UserName"
    static let EnterMessage = "Please enter message."
    static let FiveHundred = "500"
    static let Blocked = "Blocked"
    static let Post = "Post"
    static let NoSharpPickAvailable = "No Sharp Pick Available"
    static let PublicIsSplit50 = "Public is split 50/50"
    static let NotSure = "Not sure what to do!"
    static let Top = "Top"
    static let ExpertsLeaderboard = "Experts Leaderboard"
    static let Top10Handicappers = "Top 10 Handicappers get paid $3,000. "
    static let SeeRules = "See Rules"
    static let forMoreInfo = "for more info"
    static let NothingToRestore = "Nothing to restore."
    static let ProBettors = "Pro Bettors:"
    static let Top5Chatters = "Top 5 Chatters get paid. "
    static let LoginToBlock = "Login to block."
    static let AlreadyInTheCart = "Already in the cart"
    static let AddedToPickSlip = "Added to pick slip"
    static let TheMatchAlreadyStarted = "The match has already started."
    static let My = "My"
    static let Experts = "Experts"
    
    static let Amount = "Enter Amount"
    static let VenmoUserName = "Enter Venmo user name"
    static let EmailOfPhoneNumber = "Enter Email or phone number"
    static let LimitedTimeOffer = "Limited Time Offer"
    static let MostPopular = "Most Popular - Save 72%"
    
    static let TwentyNine = "$29.99"
    static let NinetyNine = "$99.99"
    static let Nineteen = "$19.99"
    static let AndThen = "and then,"
    static let PerMonth = "per month"
    static let PerYear = "per year"
    static let NoAvailable = "There are no available in-app items. Try again"
    
    static let CantBeMoreThan = "Payment requests can’t be more than real account balance"
    static let atLeast$1 = "Payment requests must be at least $1"
    static let PleaseAllowBusinessDays = "Your request has been received, please allow 7-10 business days for the payment to process.  There is a 90 day holding period on all funds after they have been deposited into your Kingpin account.  For payments over $600 a W9 is required to be on file for each year.  For any questions, please email info@kingpin.pro with your username and withdrawal request. "
    
    static let PicksPlaced = "Picks Placed"
    static let emptyCart = "Cart is empty."
    static let confirmPicks = "Please confirm your picks"
    static let MinimumPick = "The minimum pick is $50 for parlays"
    static let MaxPick = "The max pick amount is $100 for parlays"
    static let CannotMoneyLineParley = "You cannot parlay the money line and spread on a single game"
    
    static let MinPick = "The minimum pick is $50"
    static let MaxPicks = "The maximum amount you can place on a pick is $1,000"
    static let removeAllPicks = "Do you want to remove all picks?"
    
    
    static let AlertFaceId = "Do you want to login with Touch / Face ID?"
    static let AlertLogin = "Login to your KingPin.pro account"
    
    static let ContactUs = "https://kingpin.pro/contact-us"
    static let infoMail = "info@kingpin.pro"
    static let TermsOfUse = "https://kingpin.pro/terms-of-service"
    static let PrivacyPolicy = "https://kingpin.pro/privacy-policy"
    static let GoToAppStore = "https://apps.apple.com/us/app/sports-betting-picks-tip-app/id1390339038"
}

struct RCActionKey {
    static let NonSubUser = "Non_Subscribed_Users"
    static let SubUser = "Subscribed_Users"
    static let PurchaseMade = "Purchase_Made"
    
    static let FreeMonthly = "FreeMonthly"
    static let FreeYearly = "FreeYearly"
    static let Monthly = "Monthly"
    static let Yearly = "Yearly"
    
    static let FPA_Purchase = "FPA_Purchase"
    static let FPA_Monthly = "FPA_Monthly"
    static let FPA_Yearly = "FPA_Yearly"
    static let FPB_Purchase = "FPB_Purchase"
    static let FPB_Monthly = "FPB_Monthly"
    static let FPB_Yearly = "FPB_Yearly"
    static let FPC_Purchase = "FPC_Purchase"
    static let FPC_Monthly = "FPC_Monthly"
    static let FPC_Yearly = "FPC_Yearly"
    static let FPD_Purchase = "FPD_Purchase"
    static let FPD_Monthly = "FPD_Monthly"
    static let FPD_Yearly = "FPD_Yearly"

}

struct InAppConfig {
    
    static let EntitlementVIP = "VIP Member"
    static let EntitlementPro = "Pro"

    static var OfferingFreeTrialMonthly = ""//"com.kingpinpro.free.monthly2999"
    static var OfferingMonthly = ""//"com.kingpinpro.monthly29.99"
    static var OfferingYearly = ""//"com.kingpinpro.yearly"
    static let OfferingFreeTrialYearly = ""//"com.kingpinpro.free.yearly"

}

struct  ABTestingKey{
    
    static let freeMonthly = "freeMonthly"
    static let freeYearly = "freeYearly"
    static let monthlyYearly = "monthlyYearly"
    static let NoPopUp = "0"
    static let ShowPopUp = "1"
    static let ShowPaymentPopUP = "0"
    static let ShowTopKingpins = "1"
    static let ShowExpertPicks = "2"
    static let ShowChat = "3"

}


enum Sports: String {
    case NFL = "NFL"
    case NCF = "NCAAF"
    case CFL = "CFL"
    case MLB = "MLB"//Baseball
    case NBA = "NBA"
    case NCB = "NCAAB"
    case WNBA = "WNBA"
    case NHL = "NHL"//Hockey
    case Soccer = "Soccer"
    case Tennis = "Tennis"
    case Boxing = "Boxing"
    case MMA = "MMA"
    case Overall = ""//"kingpin"
    case Cricket = "Cricket"
    case Rugby = "Rugby"
    case AussieFootball = "Aussie Football"

}


enum SportsAdjust: String {
    case NFL = "NFL"
    case NCF = "NCAAF"
    case CFL = "CFL"
    case MLB = "MLB"//Baseball
    case NBA = "NBA"
    case NCB = "NCAAB"
    case WNBA = "WNBA"
    case NHL = "NHL"//Hockey
    case Soccer = "Soccer"
    case Tennis = "Tennis"
    case Boxing = "Boxing"
    case MMA = "MMA"
    case Overall = ""//"kingpin"
    case Cricket = "Cricket"
    case Rugby = "nrl"
    case AussieFootball = "AFL"

}



