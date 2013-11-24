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
static NSString *kStravaRedirectURI = nil;
static BOOL kStravaShouldPromptForAuthorization;

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

-(void)fetchUserActivitiesWithCompletion:(void(^)(NSArray *activities, NSError *error))completion {
    NSURL *url = [NSURL URLWithString:@"https://www.strava.com/api/v3/athlete/activities"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:self.requestQueue
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                               
                           }];
}
@end
