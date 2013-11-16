//
//  STRVUtility.h
//  strava-objc
//
//  Created by Eric Ito on 11/16/13.
//
//

#import <Foundation/Foundation.h>

@protocol STRVCoding;

@interface STRVUtility : NSObject

+ (STRVUtility *)sharedInstance;

+ (NSArray*)decodeArrayFromJSON:(NSDictionary*)json withKey:(NSString*)key class:(Class)cls;

/// A common date formatter that uses the ISO 8601 format
@property (nonatomic, strong, readonly) NSDateFormatter *dateFormatter;

@end
