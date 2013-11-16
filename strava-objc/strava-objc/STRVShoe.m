//
//  STRVShoe.m
//  strava-objc
//
//  Created by Eric Ito on 11/16/13.
//
//

#import "STRVCoding.h"
#import "STRVShoe.h"

@implementation STRVShoe

#pragma mark STRVCoding

-(id)initWithJSON:(NSDictionary *)json {
    self = [self init];
    if (self) {
        /*
         {
         "id": "g1",
         "primary": true,
         "name": "Running Shoes",
         "distance": 67492.94833374023,
         "resource_state": 2
         }
         */
    }
    return self;
}

-(NSDictionary *)encodeToJSON {
    return nil;
}

@end
