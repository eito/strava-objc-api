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
+(void)setStravaClientID:(NSString*)clientID;

/// Returns the clientID to be used for all requests to the Strava REST API.
+(NSString*)stravaClientID;

/// The strava authorization endpoint.
+(NSURL*)authorizationURL;

/// The strava token endpoint.
+(NSURL*)tokenURL;

@end
