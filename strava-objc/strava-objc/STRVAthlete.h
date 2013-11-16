//
//  STRVAthlete.h
//  strava-objc
//
//  Created by Eric Ito on 11/16/13.
//
//

#import <Foundation/Foundation.h>

@protocol STRVCoding;

@interface STRVAthlete : NSObject<STRVCoding>

@property (nonatomic, assign, readonly) NSUInteger athleteID;
@property (nonatomic, assign, readonly) NSUInteger resourceState; // enum
@property (nonatomic, copy, readonly) NSString *firstName;
@property (nonatomic, copy, readonly) NSString *lastName;
@property (nonatomic, strong, readonly) NSURL *profileImageMedURL;
@property (nonatomic, strong, readonly) NSURL *profileImageURL;
@property (nonatomic, copy, readonly) NSString *city;
@property (nonatomic, copy, readonly) NSString *state;
@property (nonatomic, assign, readonly) STRVGender gender;
@property (nonatomic, assign, readonly) STRVRequestStatus friendStatus;
@property (nonatomic, assign, readonly) STRVRequestStatus followerStatus;
@property (nonatomic, assign, readonly) BOOL premium;
@property (nonatomic, strong, readonly) NSDate *creationDate;
@property (nonatomic, strong, readonly) NSDate *modifiedDate;
@property (nonatomic, assign, readonly) BOOL approveFollowers;
@property (nonatomic, assign, readonly) NSUInteger followerCount;
@property (nonatomic, assign, readonly) NSUInteger friendCount;
@property (nonatomic, assign, readonly) NSUInteger mutualFriendCount;
@property (nonatomic, strong, readonly) NSArray *clubs;
@property (nonatomic, strong, readonly) NSArray *bikes;
@property (nonatomic, strong, readonly) NSArray *shoes;

@end
