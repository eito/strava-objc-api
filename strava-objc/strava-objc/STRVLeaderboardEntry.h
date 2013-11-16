//
//  STRVLeaderboardEntry.h
//  strava-objc
//
//  Created by Eric Ito on 11/16/13.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol STRVCoding;

@interface STRVLeaderboardEntry : NSObject<STRVCoding>

/// The name of this particular athlete.
@property (nonatomic, copy, readonly) NSString *athleteName;

/// The ID of this particular athlete.
@property (nonatomic, assign, readonly) NSUInteger athleteID;

/// The gender of this particular athlete.
@property (nonatomic, assign, readonly) STRVGender athleteGender;

/// The average heart rate of this athlete.
@property (nonatomic, assign, readonly) double avgHeartRate;

/// The average power of this athlete.
@property (nonatomic, assign, readonly) double avgWatts;

/// The total distance travelled by this athlete for the given segment.
@property (nonatomic, assign, readonly) double distance;

/// The total elapsed time of travel.
@property (nonatomic, assign, readonly) double elapsedTime;

/// The total amount of time this athlete was moving.
@property (nonatomic, assign, readonly) double movingTime;

/// The starting date of this particular segment.
@property (nonatomic, strong, readonly) NSDate *startDate;

/// The ID of this activity.
@property (nonatomic, assign, readonly) NSUInteger activityID;

///
@property (nonatomic, assign, readonly) NSUInteger effortID;

/// The rank of the current athlete.
@property (nonatomic, assign, readonly) NSUInteger rank;

/// The URL to the current athlete's profile picture.
@property (nonatomic, strong, readonly) NSURL *profileImageURL;

/// The image representing the athlete's profile.
@property (nonatomic, strong, readonly) UIImage *profileImage;

/// Fetches the profile image asynchronously for this particular athlete.
- (NSOperation*)fetchProfileImageWithCompletion:(void(^)(UIImage *profileImage, NSError *error))completion;

@end
