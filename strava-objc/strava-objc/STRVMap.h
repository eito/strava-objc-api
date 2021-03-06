//
//  STRVMap.h
//  strava-objc
//
//  Created by Eric Ito on 11/15/13.
//
//

#import <Foundation/Foundation.h>

@protocol STRVCoding;

@interface STRVMap : NSObject<STRVCoding>

@property (nonatomic, copy, readonly) NSString* mapID;
@property (nonatomic, assign, readonly) NSUInteger resourceState; // enum

@end
