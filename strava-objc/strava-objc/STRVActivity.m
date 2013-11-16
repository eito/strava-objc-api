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

@interface STRVActivity ()
@property (nonatomic, assign, readwrite) NSUInteger activityID;
@property (nonatomic, assign, readwrite) NSUInteger resourceState;
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
@property (nonatomic, assign, readwrite) double calories;
//@property (nonatomic, assign, readwrite) NSUInteger truncated;
@property (nonatomic, assign, readwrite) BOOL kudoed;
@property (nonatomic, copy, readwrite) NSArray *segmentEfforts;
@property (nonatomic, copy, readwrite) NSArray *splitsMetric;
@property (nonatomic, copy, readwrite) NSArray *splitsStandard;
@property (nonatomic, copy, readwrite) NSArray *bestEfforts;
@end

@implementation STRVActivity

#pragma mark STRVCoding

/*
{
    "id": 321934,
    "resource_state": 3,
    "external_id": "2012-12-12_21-40-32-80-29011.fit",
    "upload_id": 361720,
    "athlete": {
        "id": 227615,
        "resource_state": 1
    },
    "name": "12/12/2012 San Francisco",
    "distance": 4475.42,
    "moving_time": 1303,
    "elapsed_time": 1333,
    "total_elevation_gain": 8.6,
    "type": "Run",
    "start_date": "2012-12-13T03:43:19Z",
    "start_date_local": "2012-12-12T19:43:19Z",
    "timezone": "(GMT-08:00) America/Los_Angeles",
    "start_latlng": [
                     37.8,
                     -122.27
                     ],
    "end_latlng": [
                   37.8,
                   -122.27
                   ],
    "location_city": "San Francisco",
    "location_state": "CA",
    "start_latitude": 37.8,
    "start_longitude": -122.27,
    "achievement_count": 6,
    "kudos_count": 1,
    "comment_count": 1,
    "athlete_count": 1,
    "photo_count": 0,
    "map": {
        "id": "a32193479",
        "polyline": "kiteFpCBCD]",
        "summary_polyline": "{cteFjcaBkCx@gEz@R",
        "resource_state": 3
    },
    "trainer": false,
    "commute": false,
    "manual": false,
    "private": false,
    "flagged": false,
    "gear_id": "g123",
    "average_speed": 3.434704528012279,
    "max_speed": 4.514,
    "calories": 390.44092987667517,
    "truncated": 73,
    "has_kudoed": false,
    "segment_efforts": [
                        {
                            "id": 543755075,
                            "resource_state": 2,
                            "name": "Dash for the Ferry",
                            "segment": {
                                "id": 2417854,
                                "resource_state": 2,
                                "name": "Dash for the Ferry",
                                "activity_type": "Run",
                                "distance": 1055.11,
                                "average_grade": -0.0601725,
                                "maximum_grade": 2.70563,
                                "elevation_high": 4.36939,
                                "elevation_low": 2.7415,
                                "start_latlng": [
                                                 37.790578499999995,
                                                 -122.27015621666665
                                                 ],
                                "end_latlng": [
                                               37.79536648333334,
                                               -122.27964343333332
                                               ],
                                "start_latitude": 37.790578499999995,
                                "start_longitude": -122.27015621666665,
                                "end_latitude": 37.79536648333334,
                                "end_longitude": -122.27964343333332,
                                "climb_category": 0,
                                "city": "Oakland",
                                "state": "CA",
                                "private": false
                            },
                            "activity": {
                                "id": 32193479
                            },
                            "athlete": {
                                "id": 3776
                            },
                            "kom_rank": 2,
                            "pr_rank": 1,
                            "elapsed_time": 304,
                            "moving_time": 304,
                            "start_date": "2012-12-13T03:48:14Z",
                            "start_date_local": "2012-12-12T19:48:14Z",
                            "distance": 1052.33,
                            "start_index": 5348,
                            "end_index": 6485
                        }
                        ],
    "splits_metric": [
                      {
                          "distance": 1002.5,
                          "elapsed_time": 276,
                          "elevation_difference": 0,
                          "moving_time": 276,
                          "split": 1
                      },
                      {
                          "distance": 1000.4000000000001,
                          "elapsed_time": 291,
                          "elevation_difference": 2.200000000000001,
                          "moving_time": 291,
                          "split": 2
                      },
                      {
                          "distance": 1000.4000000000001,
                          "elapsed_time": 319,
                          "elevation_difference": 2.1999999999999993,
                          "moving_time": 289,
                          "split": 3
                      },
                      {
                          "distance": 998.1999999999998,
                          "elapsed_time": 308,
                          "elevation_difference": 4.199999999999999,
                          "moving_time": 308,
                          "split": 4
                      },
                      {
                          "distance": 475.6999999999998,
                          "elapsed_time": 139,
                          "elevation_difference": 0,
                          "moving_time": 139,
                          "split": 5
                      }
                      ],
    "splits_standard": [
                        {
                            "distance": 1611.2,
                            "elapsed_time": 455,
                            "elevation_difference": 2.200000000000001,
                            "moving_time": 455,
                            "split": 1
                        },
                        {
                            "distance": 1610.1000000000001,
                            "elapsed_time": 496,
                            "elevation_difference": 3.1999999999999993,
                            "moving_time": 466,
                            "split": 2
                        },
                        {
                            "distance": 1255.8999999999996,
                            "elapsed_time": 382,
                            "elevation_difference": 3.1999999999999993,
                            "moving_time": 382,
                            "split": 3
                        }
                        ],
    "best_efforts": [
                     {
                         "id": 273063933,
                         "resource_state": 2,
                         "name": "400m",
                         "segment": null,
                         "activity": {
                             "id": 32193479
                         },
                         "athlete": {
                             "id": 3776
                         },
                         "kom_rank": null,
                         "pr_rank": 1,
                         "elapsed_time": 105,
                         "moving_time": 106,
                         "start_date": "2012-12-13T03:43:19Z",
                         "start_date_local": "2012-12-12T19:43:19Z",
                         "distance": 400
                     },
                     {
                         "id": 273063935,
                         "resource_state": 2,
                         "name": "1/2 mile",
                         "segment": null,
                         "activity": {
                             "id": 32193479
                         },
                         "athlete": {
                             "id": 3776
                         },
                         "kom_rank": null,
                         "pr_rank": 1,
                         "elapsed_time": 219,
                         "moving_time": 220,
                         "start_date": "2012-12-13T03:43:19Z",
                         "start_date_local": "2012-12-12T19:43:19Z",
                         "distance": 805
                     },
                     {
                         "id": 273063937,
                         "resource_state": 2,
                         "name": "1k",
                         "segment": null,
                         "activity": {
                             "id": 32193479
                         },
                         "athlete": {
                             "id": 3776
                         },
                         "kom_rank": null,
                         "pr_rank": 1,
                         "elapsed_time": 275,
                         "moving_time": 276,
                         "start_date": "2012-12-13T03:43:19Z",
                         "start_date_local": "2012-12-12T19:43:19Z",
                         "distance": 1000
                     },
                     {
                         "id": 273063939,
                         "resource_state": 2,
                         "name": "1 mile",
                         "segment": null,
                         "activity": {
                             "id": 32193479
                         },
                         "athlete": {
                             "id": 3776
                         },
                         "kom_rank": null,
                         "pr_rank": 1,
                         "elapsed_time": 454,
                         "moving_time": 455,
                         "start_date": "2012-12-13T03:43:19Z",
                         "start_date_local": "2012-12-12T19:43:19Z",
                         "distance": 1609
                     },
                     {
                         "id": 273063941,
                         "resource_state": 2,
                         "name": "2 miles",
                         "segment": null,
                         "activity": {
                             "id": 32193479
                         },
                         "athlete": {
                             "id": 3776
                         },
                         "kom_rank": null,
                         "pr_rank": 1,
                         "elapsed_time": 950,
                         "moving_time": 921,
                         "start_date": "2012-12-13T03:43:19Z",
                         "start_date_local": "2012-12-12T19:43:19Z",
                         "distance": 3219
                     }
                     ]
}
*/

-(id)initWithJSON:(NSDictionary *)json {
    self = [self init];
    if (self) {

    }
    return self;
}

-(NSDictionary *)encodeToJSON {
    return nil;
}

@end
