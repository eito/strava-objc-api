//
//  STRVComment.h
//  strava-objc
//
//  Created by Eric Ito on 11/19/13.
//
//

#import <Foundation/Foundation.h>

@protocol STRVCoding;
@class STRVAthlete;

@interface STRVComment : NSObject<STRVCoding>

@property (nonatomic, assign, readonly) NSUInteger commentID;
@property (nonatomic, assign, readonly) NSUInteger activityID;
@property (nonatomic, assign, readonly) NSUInteger resourceState;
@property (nonatomic, copy, readonly) NSString* text;
@property (nonatomic, strong, readonly) STRVAthlete *athlete;
@property (nonatomic, strong, readonly) NSDate* created;

@end
