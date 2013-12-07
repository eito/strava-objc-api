//
//  STRVAPIClient.h
//  strava-objc
//
//  Created by Eric Ito on 11/20/13.
//
//

#import <Foundation/Foundation.h>

/// This is merely a helper class to set some global values. No objects
/// of this type should be instantiated.
@interface STRVAPIClient : NSObject

/// Sets the global access token for the logged in user.
+(void)setAccessToken:(NSString*)token;

/// Returns the currently active access token for the logged in user.
+(NSString*)accessToken;

/// Sets the clientID to be used for all requests to the Strava REST API.
+(void)setClientID:(NSString*)clientID;

/// Returns the clientID to be used for all requests to the Strava REST API.
+(NSString*)clientID;

/// Sets the clientSecret to be used for all requests to the Strava REST API.
+(void)setClientSecret:(NSString*)clientSecret;

/// Returns the clientSecret to be used for all requests to the Strava REST API.
+(NSString*)clientSecret;

/// Sets the default redirectURI to be used when authorizing an application.
/// This redirect URI must match (or be a subdomain of) the authorization callback
/// domain specified at app registration.
+(void)setRedirectURI:(NSString*)redirectURI;

/// Returns the redirectURI used when authorizing an application.
+(NSString*)redirectURI;

/// Sets a boolean indicating whether or not the app should always prompt
/// for authorization to access Strava information. Useful for debugging.
+(void)setShouldAlwaysPromptForAuthorization:(BOOL)forcePrompt;

/// Returns a boolean indicating if authorization is always prompted.
+(BOOL)shouldAlwaysPromptForAuthorization;

/// The strava authorization endpoint.
+(NSURL*)authorizationURL;

/// The strava token endpoint.
+(NSURL*)tokenURL;

/// The queue in which to place all network requests.
+(NSOperationQueue*)sharedRequestQueue;

/// retrieves the activities for the current logged in user.
+(void)fetchUserActivitiesWithCompletion:(void(^)(NSArray *activities, NSError *error))completion;

@end
