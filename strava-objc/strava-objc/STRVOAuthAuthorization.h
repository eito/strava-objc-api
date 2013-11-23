//
//  STRVOAuthAuthorization.h
//  strava-objc
//
//  Created by Eric Ito on 11/22/13.
//
//

#import <Foundation/Foundation.h>

@interface STRVOAuthAuthorization : NSObject

/// authorization URL endpoint. Defaults to +[STRVAPIClient authorizationURL] if not specified
@property (nonatomic, strong) NSURL *URL;

/// clientID obtained from registering application with http://www.strava.com/developers
@property (nonatomic, copy) NSString *clientID;

/// clientSecret obtained from registering application with http://www.strava.com/developers
@property (nonatomic, copy) NSString *clientSecret;

/// auth code obtained from the initial authorization request
@property (nonatomic, copy, readonly) NSString *authorizationCode;

/// The desired scope for this application. Defaults to STRVOAuthAccessScopePublic.
@property (nonatomic, assign) STRVOAuthAccessScope scope;

/// This redirect URI must match (or be a subdomain of) the authorization callback domain specified at app registration.
@property (nonatomic, copy) NSString *redirectURI;

@end
