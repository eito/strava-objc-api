//
//  STRVUtility.m
//  strava-objc
//
//  Created by Eric Ito on 11/16/13.
//
//

#import "STRVCoding.h"
#import "STRVUtility.h"

@interface STRVUtility ()
@property (nonatomic, strong, readwrite) NSDateFormatter *dateFormatter;
@end

@implementation STRVUtility

+ (STRVUtility *)sharedInstance {
    static STRVUtility *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[STRVUtility alloc] init];
        // Do any other initialisation stuff here
    });
    return sharedInstance;
}

-(NSDateFormatter *)dateFormatter {
    if (!_dateFormatter) {
        _dateFormatter = [[NSDateFormatter alloc] init];
        [_dateFormatter setDateFormat:@"yyyy'-'MM'-'dd'T'HH':'mm':'ss'Z'"];
    }
    return _dateFormatter;
}

+ (NSArray*)decodeArrayFromJSON:(NSDictionary*)json withKey:(NSString*)key class:(Class)cls {
    return [STRVUtility decodeArrayFromJSONArray:[json valueForKey:key] class:cls];
}

+ (NSArray*)decodeArrayFromJSONArray:(NSArray*)jsonArray class:(Class)cls {
    if (![cls conformsToProtocol:@protocol(STRVCoding)]) {
        return nil;
    }
    NSMutableArray *arr = [NSMutableArray array];
    for (NSDictionary *d in jsonArray) {
        id<STRVCoding> obj = [[cls alloc] initWithJSON:d];
        [arr addObject:obj];
    }
    return [NSArray arrayWithArray:arr];
}
@end
