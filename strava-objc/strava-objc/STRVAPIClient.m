//
//  STRVAPIClient.m
//  strava-objc
//
//  Created by Eric Ito on 11/20/13.
//
//

#import "STRVAPIClient.h"

static NSString *kStravaClientID = nil;
static NSString *kStravaClientSecret = nil;
static NSURL *kStravaAuthorizationURL = nil;
static NSURL *kStravaTokenURL = nil;
static NSString *kStravaAccessToken = nil;

@implementation STRVAPIClient

+(void)setAccessToken:(NSString *)token {
    kStravaAccessToken = token;
    NSLog(@"setting access token: %@", token);
}

+(NSString*)accessToken {
    return kStravaAccessToken;
}

+(void)setClientID:(NSString*)clientID {
    kStravaClientID = clientID;
}

+(NSString*)clientID {
    return kStravaClientID;
}

+(void)setClientSecret:(NSString *)clientSecret {
    kStravaClientSecret = clientSecret;
}

+(NSString*)clientSecret {
    return kStravaClientSecret;
}

+(NSURL*)authorizationURL {
    if (!kStravaAuthorizationURL) {
        kStravaAuthorizationURL = [NSURL URLWithString:@"https://www.strava.com/oauth/authorize"];
    }
    return kStravaAuthorizationURL;
}

+(NSURL*)tokenURL {
    if (!kStravaTokenURL) {
        kStravaTokenURL = [NSURL URLWithString:@"https://www.strava.com/oauth/token"];
    }
    return kStravaTokenURL;
}
@end
