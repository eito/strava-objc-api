//
//  STRVRequestManager.h
//  strava-objc
//
//  Created by Eric Ito on 11/20/13.
//
//

#import <Foundation/Foundation.h>

@interface STRVHTTPRequestManager : NSObject

+(id)sharedManager;

//@property (nonatomic, copy) void (^requestBlock)(NSURL *url, NSDictionary *queryParams, STRVHTTPRequestType requestType);
@end
