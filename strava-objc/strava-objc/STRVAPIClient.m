//
//  STRVAPIClient.m
//  strava-objc
//
//  Created by Eric Ito on 11/20/13.
//
//

#import "STRVAPIClient.h"
#import "STRVCoding.h"
#import "STRVEnumerations.h"
#import "STRVUtility.h"
#import "STRVActivity.h"

#import "STRVRequestOperation.h"
#import "STRVJSONRequestOperation.h"

static NSString *kStravaClientID = nil;
static NSString *kStravaClientSecret = nil;
static NSURL *kStravaAuthorizationURL = nil;
static NSURL *kStravaTokenURL = nil;
static NSString *kStravaAccessToken = nil;
static NSString *kStravaRedirectURI = nil;
static BOOL kStravaShouldPromptForAuthorization = NO;
static NSOperationQueue *kStravaSharedRequestQueue = nil;

@implementation STRVAPIClient

+(void)initialize {
    kStravaSharedRequestQueue = [NSOperationQueue new];
}

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

+(void)setRedirectURI:(NSString *)redirectURI {
    kStravaRedirectURI = redirectURI;
}

+(NSString *)redirectURI {
    return kStravaRedirectURI;
}

+(void)setShouldAlwaysPromptForAuthorization:(BOOL)forcePrompt {
    kStravaShouldPromptForAuthorization = forcePrompt;
}

+(BOOL)shouldAlwaysPromptForAuthorization {
    return kStravaShouldPromptForAuthorization;
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

+(NSOperationQueue*)sharedRequestQueue {
    return kStravaSharedRequestQueue;
}

+(void)fetchUserActivitiesWithCompletion:(void(^)(NSArray *activities, NSError *error))completion {
    
    if (![STRVAPIClient accessToken].length) {
        completion(nil, [NSError errorWithDomain:NSCocoaErrorDomain code:403 userInfo:@{ NSLocalizedDescriptionKey : @"You must set an access token on STRVAPIClient or login."}]);
    }
    // TODO: break this code out to be better managed...we shouldn't be creating requests at this level
    NSMutableString *urlString = [NSMutableString stringWithString:@"https://www.strava.com/api/v3/athlete/activities"];
    [urlString appendFormat:@"?access_token=%@", [STRVAPIClient accessToken]];
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    
    STRVJSONRequestOperation *jrop = [[STRVJSONRequestOperation alloc] initWithRequest:request];
    jrop.progressBlock = ^(long long downloaded, long long expected, double percent){
        NSLog(@"downloaded: %.2f", percent);
    };
    jrop.responseBlock = ^(NSHTTPURLResponse *response, NSURLRequest *request) {
        NSLog(@"response: %@", response);
    };
    jrop.completionBlock = ^(id obj, NSError *error) {
        NSLog(@"finished -- in completion block");
        if (error) {
            NSLog(@"completed with error: %@", error);
        }
        else {
            NSArray *activities = [STRVUtility decodeArrayFromJSONArray:obj class:[STRVActivity class]];
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(activities, error);
            });
        }
    };
    [[STRVAPIClient sharedRequestQueue] addOperation:jrop];
}
@end
