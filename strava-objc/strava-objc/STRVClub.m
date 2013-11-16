//
//  STRVClub.m
//  strava-objc
//
//  Created by Eric Ito on 11/16/13.
//
//

#import "STRVCoding.h"
#import "STRVClub.h"

@implementation STRVClub

#pragma mark STRVCoding

-(id)initWithJSON:(NSDictionary *)json {
    self = [self init];
    if (self) {
        /*
         {
         "id": 1,
         "resource_state": 2,
         "name": "Team Strava Cycling"
         }
         */
    }
    return self;
}

-(NSDictionary *)encodeToJSON {
    return nil;
}

@end
