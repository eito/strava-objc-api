//
//  STRVMap.m
//  strava-objc
//
//  Created by Eric Ito on 11/15/13.
//
//

#import "STRVCoding.h"
#import "STRVMap.h"

@interface STRVMap ()
@property (nonatomic, copy, readwrite) NSString* mapID;
@property (nonatomic, copy, readwrite) NSString *polyline; // rename?
@property (nonatomic, assign, readwrite) NSUInteger resourceState;
@end

@implementation STRVMap

#pragma mark STRVCoding

-(id)initWithJSON:(NSDictionary *)json {
    /*
    "map": {
        "id": "s229781",
        "polyline": "}g|e...VJr@",
        "resource_state": 3
    },
     */
    self = [self init];
    if (self) {
        self.mapID = json[@"id"];
        self.polyline = json[@"polyline"];
        self.resourceState = [json[@"resource_state"] unsignedIntegerValue];
    }
    return self;
}

-(NSDictionary *)encodeToJSON {
    return nil;
}

@end
