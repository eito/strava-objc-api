//
//  STRVActivity.h
//  strava-objc
//
//  Created by Eric Ito on 11/16/13.
//
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@protocol STRVCoding;
@class STRVAthlete;
@class STRVMap;

@interface STRVActivity : NSObject<STRVCoding>

/// The unique ID of this activity.
@property (nonatomic, assign, readonly) NSUInteger activityID;

/// The state of the resource.
@property (nonatomic, assign, readonly) NSUInteger resourceState;

/// A GUID identifying this activity.
@property (nonatomic, copy, readonly) NSString *guid;

@property (nonatomic, copy, readonly) NSString *externalID;

/// The unique ID of this activity that was uploaded.
@property (nonatomic, assign, readonly) NSUInteger uploadID;

/// The athlete that performed this activity.
@property (nonatomic, strong, readonly) STRVAthlete *athlete;

/// The name of this activity.
@property (nonatomic, copy, readonly) NSString *name;

/// The total distance, in meters, of this activity.
@property (nonatomic, assign, readonly) double distance;

/// The total amount of time spent moving, in seconds, for this activity.
@property (nonatomic, assign, readonly) NSUInteger movingTime;

/// The total amount of time, in seconds, for this activity.
@property (nonatomic, assign, readonly) NSUInteger elapsedTime;

/// The total amount of elevation gained, in meters.
@property (nonatomic, assign, readonly) double totalElevationGain;

/// The specific activity performed.
@property (nonatomic, assign, readonly) STRVActivityType activityType;

/// The time in which this activity was started.
@property (nonatomic, strong, readonly) NSDate *startDate;

/// The local time in which this activity was started.
@property (nonatomic, strong, readonly) NSDate *startDateLocal;

/// The time zone in which this activity was performed.
@property (nonatomic, strong, readonly) NSTimeZone *timezone;

/// The coordinate of the point in which this activity was started.
@property (nonatomic, assign, readonly) CLLocationCoordinate2D startCoordinate;

/// The coordinate of the point in which this activity ended.
@property (nonatomic, assign, readonly) CLLocationCoordinate2D endCoordinate;

/// The city in which this activity was recorded.
@property (nonatomic, copy, readonly) NSString *city;

/// The state in which this activity was recorded.
@property (nonatomic, copy, readonly) NSString *state;

/// The number of achievements obtained in this activity.
@property (nonatomic, assign, readonly) NSUInteger achievementCount;

/// The number of kudos received in this activity.
@property (nonatomic, assign, readonly) NSUInteger kudosCount;

/// The number of comments for this activity.
@property (nonatomic, assign, readonly) NSUInteger commentCount;

/// The number of athletes who also completed this activity.
@property (nonatomic, assign, readonly) NSUInteger athleteCount;

/// The number of photos attached to this activity.
@property (nonatomic, assign, readonly) NSUInteger photoCount;

/// The map of this activity.
@property (nonatomic, strong, readonly) STRVMap *map;

/// A boolean indicating whether this activity was recorded with a trainer.
@property (nonatomic, assign, readonly) BOOL trainer;

/// A boolean indicating whether this activity was a commute.
@property (nonatomic, assign, readonly) BOOL commute;

/// A boolean indicating whether this activity was manually input.
@property (nonatomic, assign, readonly) BOOL manual;

/// A boolean indicating whether this activity is private.
@property (nonatomic, assign, readonly) BOOL privateActivity;

/// A boolean indicating whether this activity is flagged as hazardous.
@property (nonatomic, assign, readonly) BOOL flagged;

/// The ID of the gear associated with this activity.
@property (nonatomic, copy, readonly) NSString *gearID;

/// The average speed for this activity.
@property (nonatomic, assign, readonly) double avgSpeed;

/// The maximum speed recorded during this activity.
@property (nonatomic, assign, readonly) double maxSpeed;

/// The average watts for this activity.
@property (nonatomic, assign, readonly) double avgWatts;

/// The number of kilojoules generated while recording this activity.
@property (nonatomic, assign, readonly) double kilojoules;

/// The number of calories burned during this activity.
@property (nonatomic, assign, readonly) double calories;

//@property (nonatomic, assign, readonly) NSUInteger truncated;

/// A boolean indicating whether or not this activity has been kudoed.
@property (nonatomic, assign, getter=hasKudoed, readonly) BOOL kudoed;

/// An array of STRVSegment objects representing the different segments of this ride.
@property (nonatomic, copy, readonly) NSArray *segmentEfforts;

@property (nonatomic, copy, readonly) NSArray *splitsMetric;

@property (nonatomic, copy, readonly) NSArray *splitsStandard;

@property (nonatomic, copy, readonly) NSArray *bestEfforts;
@end
