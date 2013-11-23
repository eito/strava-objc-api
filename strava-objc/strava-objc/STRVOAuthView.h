//
//  STRVOAuthView.h
//  strava-objc
//
//  Created by Eric Ito on 11/22/13.
//
//

#import <UIKit/UIKit.h>

@class STRVOAuthAuthorization;

@interface STRVOAuthView : UIView

/// called when either an access token is retrieved or some error occurs
@property (nonatomic, copy) void(^completion)(NSString *accessToken, NSError *error);

- (void)loadAuthorization:(STRVOAuthAuthorization*)authorization;
@end
