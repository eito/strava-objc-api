//
//  STRVNetworkActivityManager.m
//  strava-objc
//
//  Created by Eric Ito on 11/22/13.
//
//

#import "STRVNetworkActivityManager.h"

static STRVNetworkActivityManager *kManager = nil;

@interface STRVNetworkActivityManager () {
    int _count;
}

@end

@implementation STRVNetworkActivityManager

+(instancetype)manager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        kManager = [STRVNetworkActivityManager new];
    });
    return kManager;
}

-(void)show {
    @synchronized(self){
        ++_count;
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    }
}

-(void)hide {
    @synchronized(self){
        if (--_count == 0) {
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        }
    }
}

@end
