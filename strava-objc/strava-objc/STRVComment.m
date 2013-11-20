//
//  STRVComment.m
//  strava-objc
//
//  Created by Eric Ito on 11/19/13.
//
//

#import "STRVCoding.h"
#import "STRVEnumerations.h"
#import "STRVComment.h"
#import "STRVAthlete.h"
#import "STRVUtility.h"

@interface STRVComment()
@property (nonatomic, assign, readwrite) NSUInteger commentID;
@property (nonatomic, assign, readwrite) NSUInteger activityID;
@property (nonatomic, assign, readwrite) NSUInteger resourceState;
@property (nonatomic, copy, readwrite) NSString* text;
@property (nonatomic, strong, readwrite) STRVAthlete *athlete;
@property (nonatomic, strong, readwrite) NSDate* created;
@end

@implementation STRVComment


#pragma mark STRVCoding

-(id)initWithJSON:(NSDictionary *)json {
    self = [self init];
    if (self) {
        self.commentID = [[json valueForKey:@"id"] unsignedIntegerValue];
        self.activityID = [[json valueForKey:@"activity_id"] unsignedIntegerValue];
        self.resourceState = [[json valueForKey:@"resource_state"] unsignedIntegerValue];
        self.text = [json valueForKey:@"text"];
        self.athlete = [[STRVAthlete alloc] initWithJSON:[json valueForKey:@"athlete"]];
        self.created = [[[STRVUtility sharedInstance] dateFormatter] dateFromString:[json valueForKey:@"created_at"]];
    }
    return self;
}

-(NSDictionary *)encodeToJSON {
    return nil;
}
@end
