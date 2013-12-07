//
//  STRVActivity.m
//  strava-objc
//
//  Created by Eric Ito on 11/16/13.
//
//

#import "STRVCoding.h"
#import "STRVEnumerations.h"
#import "STRVActivity.h"
#import "STRVAthlete.h"
#import "STRVMap.h"
#import "STRVUtility.h"
#import "STRVSegment.h"

@interface STRVActivity ()
@property (nonatomic, assign, readwrite) NSUInteger activityID;
@property (nonatomic, assign, readwrite) NSUInteger resourceState;
@property (nonatomic, copy, readwrite) NSString *guid;
@property (nonatomic, copy, readwrite) NSString *externalID;
@property (nonatomic, assign, readwrite) NSUInteger uploadID;
@property (nonatomic, strong, readwrite) STRVAthlete *athlete;
@property (nonatomic, copy, readwrite) NSString *name;
@property (nonatomic, assign, readwrite) double distance;
@property (nonatomic, assign, readwrite) NSUInteger movingTime;
@property (nonatomic, assign, readwrite) NSUInteger elapsedTime;
@property (nonatomic, assign, readwrite) double totalElevationGain;
@property (nonatomic, assign, readwrite) STRVActivityType activityType;
@property (nonatomic, strong, readwrite) NSDate *startDate;
@property (nonatomic, strong, readwrite) NSDate *startDateLocal;
@property (nonatomic, strong, readwrite) NSTimeZone *timezone;
@property (nonatomic, assign, readwrite) CLLocationCoordinate2D startCoordinate;
@property (nonatomic, assign, readwrite) CLLocationCoordinate2D endCoordinate;
@property (nonatomic, copy, readwrite) NSString *city;
@property (nonatomic, copy, readwrite) NSString *state;
@property (nonatomic, assign, readwrite) NSUInteger achievementCount;
@property (nonatomic, assign, readwrite) NSUInteger kudosCount;
@property (nonatomic, assign, readwrite) NSUInteger commentCount;
@property (nonatomic, assign, readwrite) NSUInteger athleteCount;
@property (nonatomic, assign, readwrite) NSUInteger photoCount;
@property (nonatomic, strong, readwrite) STRVMap *map;
@property (nonatomic, assign, readwrite) BOOL trainer;
@property (nonatomic, assign, readwrite) BOOL commute;
@property (nonatomic, assign, readwrite) BOOL manual;
@property (nonatomic, assign, readwrite) BOOL privateActivity;
@property (nonatomic, assign, readwrite) BOOL flagged;
@property (nonatomic, copy, readwrite) NSString *gearID;
@property (nonatomic, assign, readwrite) double avgSpeed;
@property (nonatomic, assign, readwrite) double maxSpeed;
@property (nonatomic, assign, readwrite) double avgWatts;
@property (nonatomic, assign, readwrite) double kilojoules;
@property (nonatomic, assign, readwrite) double calories;
//@property (nonatomic, assign, readwrite) NSUInteger truncated;
@property (nonatomic, assign, getter=hasKudoed, readwrite) BOOL kudoed;
@property (nonatomic, copy, readwrite) NSArray *segmentEfforts;
@property (nonatomic, copy, readwrite) NSArray *splitsMetric;
@property (nonatomic, copy, readwrite) NSArray *splitsStandard;
@property (nonatomic, copy, readwrite) NSArray *bestEfforts;
@end

@implementation STRVActivity

-(NSString *)description {
    return [NSString stringWithFormat:@"On %@ --- %@ - %.2fm - %u seconds", self.startDate, self.name, self.distance, self.movingTime];
}

#pragma mark STRVCoding

-(id)initWithJSON:(NSDictionary *)json {
    self = [self init];
    if (self) {
        self.activityID = [[json valueForKey:@"id"] unsignedIntegerValue];
        self.resourceState = [[json valueForKey:@"resource_state"] unsignedIntegerValue];
        self.guid = [json valueForKey:@"guid"];
        self.externalID = [json valueForKey:@"external_id"];
        self.uploadID = [[json valueForKey:@"upload_id"] unsignedIntegerValue];
        self.athlete = [[STRVAthlete alloc] initWithJSON:[json valueForKey:@"athlete"]];
        self.name = [json valueForKey:@"name"];
        self.distance = [[json valueForKey:@"distance"] doubleValue];
        self.movingTime = [[json valueForKey:@"moving_time"] unsignedIntegerValue];
        self.elapsedTime = [[json valueForKey:@"elapsed_time"] unsignedIntegerValue];
        self.totalElevationGain = [[json valueForKey:@"total_elevation_gain"] doubleValue];
        self.activityType = STRVActivityTypeFromString([json valueForKey:@"type"]);
        self.startDate = [[[STRVUtility sharedInstance] dateFormatter] dateFromString:[json valueForKey:@"start_date"]];
        self.startDateLocal = [[[STRVUtility sharedInstance] dateFormatter] dateFromString:[json valueForKey:@"start_date_local"]];
        
        // timezone --   "timezone":"(GMT+10:00) Australia/Brisbane",
        
        NSArray *startCoords = [json valueForKey:@"start_latlng"];
        self.startCoordinate = CLLocationCoordinate2DMake([startCoords[0] doubleValue], [startCoords[1] doubleValue]);
        NSArray *endCoords = [json valueForKey:@"end_latlng"];
        self.endCoordinate = CLLocationCoordinate2DMake([endCoords[0] doubleValue], [endCoords[1] doubleValue]);
        self.city = [json valueForKey:@"location_city"];
        self.state = [json valueForKey:@"location_state"];
        self.achievementCount = [[json valueForKey:@"achievement_count"] unsignedIntegerValue];
        self.kudosCount = [[json valueForKey:@"kudos_count"] unsignedIntegerValue];
        self.commentCount = [[json valueForKey:@"comment_count"] unsignedIntegerValue];
        self.athleteCount = [[json valueForKey:@"athlete_count"] unsignedIntegerValue];
        self.photoCount = [[json valueForKey:@"photo_count"] unsignedIntegerValue];
        self.map = [[STRVMap alloc] initWithJSON:[json valueForKey:@"map"]];
        self.trainer = [[json valueForKey:@"trainer"] boolValue];
        self.commute = [[json valueForKey:@"commute"] boolValue];
        self.manual = [[json valueForKey:@"manual"] boolValue];
        self.privateActivity = [[json valueForKey:@"private"] boolValue];
        self.flagged = [[json valueForKey:@"flagged"] boolValue];
        self.gearID = [json valueForKey:@"gear_id"];
        self.avgSpeed = [[json valueForKey:@"average_speed"] doubleValue];
        self.maxSpeed = [[json valueForKey:@"max_speed"] doubleValue];
        self.avgWatts = [[json valueForKey:@"average_watts"] doubleValue];
        self.kilojoules = [[json valueForKey:@"kilojoules"] doubleValue];
        self.calories = [[json valueForKey:@"calories"] doubleValue];
        self.kudoed = [[json valueForKey:@"has_kudoed"] boolValue];
        self.segmentEfforts = [STRVUtility decodeArrayFromJSON:json withKey:@"segment_efforts" class:[STRVSegment class]];
        
//        self.splitsMetric;
//        self.splitsStandard;
//        self.bestEfforts;
    }
    return self;
}

-(NSDictionary *)encodeToJSON {
    return nil;
}

@end
