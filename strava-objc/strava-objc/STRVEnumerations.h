//
//  STRVEnumerations.h
//  strava-objc
//
//  Created by Eric Ito on 11/16/13.
//
//


typedef NS_ENUM(NSInteger, STRVGender) {
    STRVGenderUnspecified = -1,
    STRVGenderMale,
    STRVGenderFemale
};

STRVGender STRVGenderFromString(NSString *gender);
NSString *NSStringFromSTRVGender(STRVGender gender);

typedef NS_ENUM(NSInteger, STRVActivityType) {
    STRVActivityTypeRide,
    STRVActivityTypeRun
};

STRVActivityType STRVActivityTypeFromString(NSString *activityType);
NSString *NSStringFromSTRVActivityType(STRVActivityType activityType);


// pending, accepted, blocked, null
typedef NS_ENUM(NSInteger, STRVRequestStatus) {
    STRVRequestStatusNone = -1,
    STRVRequestStatusPending,
    STRVRequestStatusAccepted,
    STRVRequestStatusBlocked
};

STRVRequestStatus STRVRequestStatusFromString(NSString *status);
NSString *NSStringFromSTRVRequestStatus(STRVRequestStatus status);

typedef NS_ENUM(NSInteger, STRVHTTPRequestType) {
    STRVHTTPRequestTypeGet,
    STRVHTTPRequestTypePost,
};

/// "public" "write" "view_private" "view_private,write"
typedef NS_ENUM(NSUInteger, STRVOAuthAccessScope) {
    STRVOAuthAccessScopePublic,
    STRVOAuthAccessScopeWrite,
    STRVOAuthAccessScopeViewPrivate,
    STRVOAuthAccessScopeAll
};

STRVOAuthAccessScope STRVOAuthAccessScopeFromString(NSString *scope);
NSString *NSStringFromSTRVOAuthAccessScope(STRVOAuthAccessScope scope);