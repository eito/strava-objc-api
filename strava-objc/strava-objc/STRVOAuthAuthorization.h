//
//  STRVOAuthAuthorization.h
//  strava-objc
//
//  Created by Eric Ito on 11/22/13.
//
//

#import <Foundation/Foundation.h>

@interface STRVOAuthAuthorization : NSObject

/// authorization URL endpoint.
/// Returns +[STRVAPIClient authorizationURL].
@property (nonatomic, strong, readonly) NSURL *URL;

/// clientID obtained from registering application with http://www.strava.com/developers
/// Returns +[STRVAPIClient clientID].
@property (nonatomic, copy, readonly) NSString *clientID;

/// clientSecret obtained from registering application with http://www.strava.com/developers
/// Returns +[STRVAPIClient clientSecret].
@property (nonatomic, copy, readonly) NSString *clientSecret;

/// auth code obtained from the initial authorization request
@property (nonatomic, copy, readonly) NSString *authorizationCode;

/// The desired scope for this application. Defaults to STRVOAuthAccessScopePublic.
@property (nonatomic, assign, readonly) STRVOAuthAccessScope scope;

/// The redirectURI for authorizing applications. Returns +[STRVAPIClient redirectURI];
@property (nonatomic, copy, readonly) NSString *redirectURI;

/// Initialize an authorization with the specified scope.
/// Designated Initializer.
-(id)initWithScope:(STRVOAuthAccessScope)scope;

@end
