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
@property (nonatomic, assign, readwrite) STRVOAuthAccessScope scope;
@end

@implementation STRVOAuthAuthorization

-(id)initWithScope:(STRVOAuthAccessScope)scope {
    self = [super init];
    if (self) {
        self.scope = scope;
    }
    return self;
}

#pragma mark Getters

-(NSURL *)URL {
    return [STRVAPIClient authorizationURL];
}

-(NSString*)clientID {
    return [STRVAPIClient clientID];
}

-(NSString *)clientSecret {
    return [STRVAPIClient clientSecret];
}

-(NSString *)redirectURI {
    return [STRVAPIClient redirectURI];
}


@end
