//
//  STRVSegment.h
//  strava-objc
//
//  Created by Eric Ito on 11/15/13.
//
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@protocol STRVCoding;
@class STRVMap;

@interface STRVSegment : NSObject<STRVCoding>

/// The ID of this particular segment.
@property (nonatomic, assign, readonly) NSUInteger segmentID;

@property (nonatomic, assign, readonly) NSUInteger resourceState;      // enum -- meta, summart, detailed

/// The name of this segment.
@property (nonatomic, copy, readonly)   NSString *name;

/// Specifies the type of activity associated with this segment.
@property (nonatomic, assign, readonly) STRVActivityType activityType;

/// Segment distance in meters.
@property (nonatomic, assign, readonly) double distance;

/// Average grade for this segment (%).
@property (nonatomic, assign, readonly) double avgGrade;

/// Maximum grade for this segment (%).
@property (nonatomic, assign, readonly) double maxGrade;

/// The highest elevation achieved during this segment (in meters).
@property (nonatomic, assign, readonly) double maxElevation;

/// The lowest elevation achieved during this segment (in meters).
@property (nonatomic, assign, readonly) double minElevation;

/// Location of the starting coordinate of this segment.
@property (nonatomic, assign, readonly) CLLocationCoordinate2D startCoordinate;

/// Location of the ending coordinate of this segment.
@property (nonatomic, assign, readonly) CLLocationCoordinate2D endCoordinate;

/// The ranking for this particular climb (0-5, lower is harder).
@property (nonatomic, assign, readonly) NSUInteger climbCategory;      //enum?

/// The city in which this segment is located.
@property (nonatomic, copy, readonly)   NSString *city;

/// The state in which this segment is located.
@property (nonatomic, copy, readonly)   NSString *state;

/// Specifies whether or not this segment is private.
@property (nonatomic, assign, getter=isPrivateSegment, readonly) BOOL privateSegment;

/// The date in which this segment was created.
@property (nonatomic, strong, readonly) NSDate *created;

/// The last modified time of this segment.
@property (nonatomic, strong, readonly) NSDate *modified;

/// The total amount of elevation gained during this segment, in meters.
@property (nonatomic, assign, readonly) double totalElevationGain;

@property (nonatomic, strong, readonly) STRVMap *map;

/// The number of times this segment has been ridden.
@property (nonatomic, assign, readonly) NSUInteger effortCount;

/// The number of unique athletes that have ridden this segment.
@property (nonatomic, assign, readonly) NSUInteger athleteCount;

/// A boolean indicating whether or not this segment has been flagged as hazardous.
@property (nonatomic, assign, getter=isHazardous, readonly) BOOL hazardous;

/// Specifies the time, in seconds, of the authenticated rider's PR. (Can be nil)
@property (nonatomic, assign, readonly) NSUInteger prTime;         // rename?

/// Specifies the distance, in meters, of the authenticated rider's PR. (Can be nil)
@property (nonatomic, assign, readonly) NSUInteger prDistance;     // rename?

/// Specifies if the authenticated athlete has starred this segment.
@property (nonatomic, assign, getter = isStarred, readonly) BOOL starred;

@end
