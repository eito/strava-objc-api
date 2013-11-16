//
//  STRVLeaderboardEntry.m
//  strava-objc
//
//  Created by Eric Ito on 11/16/13.
//
//

#import "STRVCoding.h"
#import "STRVEnumerations.h"
#import "STRVLeaderboardEntry.h"
#import "STRVUtility.h"

@interface STRVLeaderboardEntry ()

@property (nonatomic, copy, readwrite) NSString *athleteName;
@property (nonatomic, assign, readwrite) NSUInteger athleteID;
@property (nonatomic, assign, readwrite) STRVGender athleteGender;
@property (nonatomic, assign, readwrite) double avgHeartRate;
@property (nonatomic, assign, readwrite) double avgWatts;
@property (nonatomic, assign, readwrite) double distance;
@property (nonatomic, assign, readwrite) double elapsedTime;
@property (nonatomic, assign, readwrite) double movingTime;
@property (nonatomic, strong, readwrite) NSDate *startDate;
@property (nonatomic, assign, readwrite) NSUInteger activityID;
@property (nonatomic, assign, readwrite) NSUInteger effortID;
@property (nonatomic, assign, readwrite) NSUInteger rank;
@property (nonatomic, strong, readwrite) NSURL *profileImageURL;

@property (nonatomic, strong, readwrite) UIImage *profileImage;
@end

@implementation STRVLeaderboardEntry


- (NSOperation*)fetchProfileImageWithCompletion:(void(^)(UIImage *profileImage, NSError *error))completion {
    return nil;
}

#pragma mark STRVCoding

-(id)initWithJSON:(NSDictionary *)json {

    /*
     {
     "athlete_name": "Jim Whimpey",
     "athlete_id": 123529,
     "athlete_gender": "M",
     "average_hr": 190.519,
     "average_watts": 460.805,
     "distance": 2659.89,
     "elapsed_time": 360,
     "moving_time": 360,
     "start_date": "2013-03-29T13:49:35Z",
     "start_date_local": "2013-03-29T06:49:35Z",
     "activity_id": 46320211,
     "effort_id": 801006623,
     "rank": 1,
     "athlete_profile": "http://pics.com/227615/large.jpg"
     },
     */
    self = [self init];
    if (self) {
        self.athleteName = json[@"athlete_name"];
        self.athleteID = [json[@"athlete_id"] unsignedIntegerValue];
        self.athleteGender = STRVGenderFromString([json valueForKey:@"athlete_gender"]);
        self.avgHeartRate = [json[@"average_hr"] doubleValue];
        self.avgWatts = [json[@"average_watts"] doubleValue];
        self.distance = [json[@"distance"] doubleValue];
        self.elapsedTime = [json[@"elapsed_time"] unsignedIntegerValue];
        self.movingTime = [json[@"moving_time"] unsignedIntegerValue];
        NSDateFormatter *df = [[STRVUtility sharedInstance] dateFormatter];
        self.startDate = [df dateFromString:json[@"start_date"]];
        self.activityID = [json[@"activity_id"] unsignedIntegerValue];
        self.effortID = [json[@"effort_id"] unsignedIntegerValue];
        self.rank = [json[@"rank"] unsignedIntegerValue];
        self.profileImageURL = [NSURL URLWithString:json[@"athlete_profile"]];
        
    }
    return self;
}

-(NSDictionary *)encodeToJSON {
    return nil;
}

@end
