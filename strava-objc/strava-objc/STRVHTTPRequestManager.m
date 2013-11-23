//
//  STRVRequestManager.m
//  strava-objc
//
//  Created by Eric Ito on 11/20/13.
//
//

#import "STRVEnumerations.h"
#import "STRVHTTPRequestManager.h"

@implementation STRVHTTPRequestManager

+(id)sharedManager {
    //  Static local predicate must be initialized to 0
    static STRVHTTPRequestManager *kSharedInstance = nil;
    static dispatch_once_t onceToken = 0;
    dispatch_once(&onceToken, ^{
        kSharedInstance = [STRVHTTPRequestManager new];
        // Do any other initialization stuff here
    });
    return kSharedInstance;
}

@end
