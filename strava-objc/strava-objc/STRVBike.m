//
//  STRVBike.m
//  strava-objc
//
//  Created by Eric Ito on 11/16/13.
//
//

#import "STRVCoding.h"
#import "STRVBike.h"

@implementation STRVBike

#pragma mark STRVCoding

-(id)initWithJSON:(NSDictionary *)json {
    self = [self init];
    if (self) {
        /*
         {
         "id": "b105763",
         "primary": false,
         "name": "Cannondale TT",
         "distance": 476612.8984375,
         "resource_state": 2
         },
         */
    }
    return self;
}

-(NSDictionary *)encodeToJSON {
    return nil;
}

@end
