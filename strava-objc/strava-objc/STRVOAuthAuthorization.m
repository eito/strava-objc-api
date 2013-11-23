//
//  STRVOAuthAuthorization.m
//  strava-objc
//
//  Created by Eric Ito on 11/22/13.
//
//

#import "STRVEnumerations.h"
#import "STRVOAuthAuthorization.h"
#import "STRVAPIClient.h"

@interface STRVOAuthAuthorization ()
@property (nonatomic, copy, readwrite) NSString *authorizationCode;
@end

@implementation STRVOAuthAuthorization

-(id)init {
    self = [super init];
    if (self) {
        self.URL = [STRVAPIClient authorizationURL];
        self.scope = STRVOAuthAccessScopePublic;
    }
    return self;
}
@end
