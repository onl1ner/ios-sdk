//
//  PersonalizationSDK.swift
//

import Foundation

public enum Event {
    case productView (id: String)
    case categoryView (id: String)
    case productAddedToFavorities(id: String)
    case productRemovedToFavorities(id: String)
    case productAddedToCart (id: String)
    case productRemovedFromCart (id: String)
    case synchronizeCart (items: [CartItem])
    case orderCreated(orderId: String, totalValue: Double, products: [(id: String, amount: Int)])
}

public enum SDKError: Error {
    case incorrectAPIKey
    case initializationFailed
    case noError
    case responseError
    case invalidResponse
    case decodeError
    case custom(error: String)
}


public protocol PersonalizationSDK {
    func setProfileData(userEmail: String, userPhone: String?, userLoyaltyId: String?, userId: String?, birthday: Date?, age: Int?, firstName: String?, lastName: String?, location: String?, gender: Gender?, fbID: String?, vkID: String?, telegramID: String?, loyaltyCardLocation: String?, loyaltyStatus: String?, loyaltyBonuses: Int?, loyaltyBonusesToNextLevel: Int?, boughtSomething: Bool?, customProperties: [String: String?]?, completion: @escaping (Result<Void, SDKError>) -> Void)
    func track(event: Event, recommendedBy: RecomendedBy?, completion: @escaping (Result<Void, SDKError>) -> Void)
    func trackSource(source: RecommendedByCase, code: String)
    func trackEvent(event: String, category: String?, label: String?, value: Int?, completion: @escaping (Result<Void, SDKError>) -> Void)
    func recommend(blockId: String, currentProductId: String?, locations: String?, imageSize: String?,timeOut: Double?, completion: @escaping (Result<RecommenderResponse, SDKError>) -> Void)
    func suggest(query: String, locations: String?, timeOut: Double?, extended: String?, completion: @escaping(Result<SearchResponse, SDKError>) -> Void)
    func search(query: String, limit: Int?, offset: Int?, categoryLimit: Int?, categories: String?, extended: String?, sortBy: String?, sortDir: String?, locations: String?, brands: String?, filters: [String: Any]?, priceMin: Double?, priceMax: Double?, colors: String?, exclude: String?, email: String?, timeOut: Double?, disableClarification: Bool?, completion: @escaping(Result<SearchResponse, SDKError>) -> Void)
    func getDeviceID() -> String
    func getSession() -> String
    func getCurrentSegment() -> String
    func setPushTokenNotification(token: String, completion: @escaping(Result<Void, SDKError>) -> Void)
    func review(rate: Int, channel: String, category: String, orderId: String?, comment: String?, completion: @escaping(Result<Void, SDKError>) -> Void)
    func searchBlank(completion: @escaping(Result<SearchBlankResponse, SDKError>) -> Void)
    func notificationClicked(type: String, code: String, completion: @escaping (Result<Void, SDKError>) -> Void)
}

public extension PersonalizationSDK {
    
    func review(rate: Int, channel: String, category: String, orderId: String? = nil, comment: String? = nil, completion: @escaping(Result<Void, SDKError>) -> Void) {
        review(rate: rate, channel: channel, category: category, orderId: orderId, comment: comment, completion: completion)
    }

    func setProfileData(userEmail: String, userPhone: String? = nil, userLoyaltyId: String? = nil, userId: String? = nil, birthday: Date? = nil, age: Int? = nil, firstName: String? = nil, lastName: String? = nil, location: String? = nil, gender: Gender? = nil, fbID: String? = nil, vkID: String? = nil, telegramID: String? = nil, loyaltyCardLocation: String? = nil, loyaltyStatus: String? = nil, loyaltyBonuses: Int? = nil, loyaltyBonusesToNextLevel: Int? = nil, boughtSomething: Bool? = nil, customProperties: [String: String?]? = nil, completion: @escaping (Result<Void, SDKError>) -> Void) {
        setProfileData(userEmail: userEmail, userPhone: userPhone, userLoyaltyId: userLoyaltyId, userId: userId, birthday: birthday, age: age, firstName: firstName, lastName: lastName, location: location, gender: gender, fbID: fbID, vkID: vkID, telegramID: telegramID, loyaltyCardLocation: loyaltyCardLocation, loyaltyStatus: loyaltyStatus, loyaltyBonuses: loyaltyBonuses, loyaltyBonusesToNextLevel: loyaltyBonusesToNextLevel, boughtSomething: boughtSomething, customProperties: customProperties, completion: completion)
    }

    func recommend(blockId: String, currentProductId: String? = nil, locations: String? = nil, imageSize: String? = nil, timeOut: Double? = nil, completion: @escaping (Result<RecommenderResponse, SDKError>) -> Void) {
        recommend(blockId: blockId, currentProductId: currentProductId, locations: locations, imageSize: imageSize, timeOut: timeOut, completion: completion)
    }
    
    func suggest(query: String, locations: String? = nil, timeOut: Double? = nil, extended: String? = nil, completion: @escaping(Result<SearchResponse, SDKError>) -> Void) {
        suggest(query: query, locations: locations, timeOut: timeOut, extended: extended, completion: completion)
    }

    func search(query: String, limit: Int? = nil, offset: Int? = nil, categoryLimit: Int? = nil, categories: String? = nil, extended: String? = nil, sortBy: String? = nil, sortDir: String? = nil, locations: String? = nil, brands: String? = nil, filters: [String: Any]? = nil, priceMin: Double? = nil, priceMax: Double? = nil, colors: String? = nil, exclude: String? = nil, email: String? = nil, timeOut: Double? = nil, disableClarification: Bool? = nil, completion: @escaping(Result<SearchResponse, SDKError>) -> Void) {
        search(query: query, limit: limit, offset: offset, categoryLimit: categoryLimit, categories: categories, extended: extended, sortBy: sortBy, sortDir: sortDir, locations: locations, brands: brands, filters: filters, priceMin: priceMin, priceMax: priceMax, colors: colors, exclude: exclude, email: email, timeOut: timeOut, disableClarification: disableClarification, completion: completion)
    }
    
    func track(event: Event, recommendedBy: RecomendedBy? = nil, completion: @escaping (Result<Void, SDKError>) -> Void) {
        track(event: event, recommendedBy: recommendedBy, completion: completion)
    }
    
    func trackEvent(event: String, category: String? = nil, label: String? = nil, value: Int? = nil, completion: @escaping (Result<Void, SDKError>) -> Void) {
        trackEvent(event: event, category: category, label: label, value: value, completion: completion)
    }
    
    func notificationClicked(type: String, code: String, completion: @escaping (Result<Void, SDKError>) -> Void) {
        notificationClicked(type: type, code: code, completion: completion)
    }

}

public func createPersonalizationSDK(shopId: String, userEmail: String? = nil, userPhone: String? = nil, userLoyaltyId: String? = nil, apiDomain: String = "api.rees46.com", stream: String = "ios", enableLogs: Bool = false, _ completion: ((SDKError?) -> Void)? = nil) -> PersonalizationSDK{
    let sdk = SimplePersonalizationSDK(shopId: shopId, userEmail: userEmail, userPhone: userPhone, userLoyaltyId: userLoyaltyId, apiDomain: apiDomain, stream: stream, enableLogs: enableLogs, completion: completion)
    return sdk
}
