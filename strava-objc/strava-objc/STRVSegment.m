//
//  STRVSegment.m
//  strava-objc
//
//  Created by Eric Ito on 11/15/13.
//
//

#import "STRVCoding.h"
#import "STRVEnumerations.h"
#import "STRVSegment.h"
#import "STRVUtility.h"

@interface STRVSegment ()
@property (nonatomic, assign, readwrite) NSUInteger segmentID;
@property (nonatomic, assign, readwrite) NSUInteger resourceState;      // enum
@property (nonatomic, copy, readwrite)   NSString *name;
@property (nonatomic, assign, readwrite) STRVActivityType activityType;
@property (nonatomic, assign, readwrite) double distance;
@property (nonatomic, assign, readwrite) double avgGrade;
@property (nonatomic, assign, readwrite) double maxGrade;
@property (nonatomic, assign, readwrite) double maxElevation;
@property (nonatomic, assign, readwrite) double minElevation;
@property (nonatomic, assign, readwrite) CLLocationCoordinate2D startCoordinate;
@property (nonatomic, assign, readwrite) CLLocationCoordinate2D endCoordinate;
@property (nonatomic, assign, readwrite) NSUInteger climbCategory;      //enum?
@property (nonatomic, copy, readwrite)   NSString *city;
@property (nonatomic, copy, readwrite)   NSString *state;
@property (nonatomic, assign, readwrite) BOOL privateSegment;
@property (nonatomic, strong, readwrite) NSDate *created;
@property (nonatomic, strong, readwrite) NSDate *modified;
@property (nonatomic, assign, readwrite) double totalElevationGain;
//@property (nonatomic, strong, readwrite) STRVMap *map;
@property (nonatomic, assign, readwrite) NSUInteger effortCount;
@property (nonatomic, assign, readwrite) NSUInteger athleteCount;
@property (nonatomic, assign, getter=isHazardous, readwrite) BOOL hazardous;
@property (nonatomic, assign, readwrite) NSUInteger prTime;         // rename?
@property (nonatomic, assign, readwrite) NSUInteger prDistance;     // rename?
@property (nonatomic, assign, getter = isStarred, readwrite) BOOL starred;

@property (nonatomic, copy) NSString *points;

@end

@implementation STRVSegment

#pragma mark STRVCoding

/*
 {
 "id": 229781,
 "resource_state": 3,
 "name": "Hawk Hill",
 "activity_type": "Ride",
 "distance": 2684.82,
 "average_grade": 5.69309,
 "maximum_grade": 14.2443,
 "elevation_high": 245.273,
 "elevation_low": 92.424,
 "start_latlng": [
 37.8331119,
 -122.4834356
 ],
 "end_latlng": [
 37.8280722,
 -122.4981393
 ],
 "start_latitude": 37.8331119,
 "start_longitude": -122.4834356,
 "end_latitude": 37.8280722,
 "end_longitude": -122.4981393,
 "climb_category": 1,
 "city": "San Francisco",
 "state": "CA",
 "private": false,
 "created_at": "2008-01-01T17:44:00Z",
 "updated_at": "2013-09-04T20:00:50Z",
 "total_elevation_gain": 155.733,  // elev_difference
 "map": {
 "id": "s229781",
 "polyline": "}g|e...VJr@",
 "resource_state": 3
 },
 "effort_count": 51335,
 "athlete_count": 7036,
 "hazardous": false,
 "pr_time": 550,
 "pr_distance": 2713.32,
 "starred": false
 }
 */


/*
 
 // this comes back from segment explorer
 {
 "id": 229781,
 "name": "Hawk Hill",
 "climb_category": 1,
 "climb_category_desc": "4",
 "avg_grade": 5.69309,
 "start_latlng": [
 37.8331119,
 -122.4834356
 ],
 "end_latlng": [
 37.8280722,
 -122.4981393
 ],
 "elev_difference": 152.849,
 "distance": 2684.82,
 "points": "}g|eFnm@n@Op@VJr@"
 },
 */

-(id)initWithJSON:(NSDictionary *)json {
    self = [self init];
    if (self) {
        self.segmentID = [json[@"id"] unsignedIntegerValue];
        self.resourceState = [json[@"resource_state"] unsignedIntegerValue];
        self.name = json[@"name"];
        self.activityType = STRVActivityTypeFromString([json valueForKey:@"activity_type"]);
        self.distance = [json[@"distance"] doubleValue];
        self.avgGrade = [json[@"average_grade"] doubleValue];
        self.maxGrade = [json[@"maximum_grade"] doubleValue];
        self.maxElevation = [json[@"elevation_high"] doubleValue];
        self.minElevation = [json[@"elevation_low"] doubleValue];
        NSArray *startLatLng = json[@"start_latlng"];
        self.startCoordinate = (CLLocationCoordinate2D){ [startLatLng[0] doubleValue], [startLatLng[1] doubleValue] };
        NSArray *endLatLng = json[@"end_latlng"];
        self.endCoordinate = (CLLocationCoordinate2D){ [endLatLng[0] doubleValue], [endLatLng[1] doubleValue] };
        self.climbCategory = [json[@"climb_category"] unsignedIntegerValue];
        self.city = json[@"city"];
        self.state = json[@"state"];
//        self.private = [json[@"private"] boolValue];
        NSDateFormatter *df = [[STRVUtility sharedInstance] dateFormatter];
        self.created = [df dateFromString:json[@"created_at"]];
        self.modified = [df dateFromString:json[@"modified_at"]];
        self.totalElevationGain = [json[@"elev_difference"] doubleValue];
//        self.map = [[STRVMap alloc] initWithJSON:json[@"map"]];
        self.effortCount = [json[@"effort_count"] unsignedIntegerValue];
        self.athleteCount = [json[@"athlete_count"] unsignedIntegerValue];
        self.hazardous = [json[@"hazardous"] boolValue];
        self.prTime = [json[@"prTime"] unsignedIntegerValue];
        self.prDistance = [json[@"prDistance"] doubleValue];
        self.starred = [json[@"starred"] boolValue];
        
        self.points = json[@"points"];
    }
    return self;
}

-(NSDictionary *)encodeToJSON {
    return nil;
}

@end
