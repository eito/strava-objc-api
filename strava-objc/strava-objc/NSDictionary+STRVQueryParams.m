//
//  NSDictionary+STRVQueryParams.m
//  strava-objc
//
//  Created by Eric Ito on 11/22/13.
//
//

#import "NSDictionary+STRVQueryParams.h"

@implementation NSDictionary (STRVQueryParams)

-(NSString*)strv_encodeStringQueryParams {
    NSMutableString *queryString = [NSMutableString string];
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        if ([key isKindOfClass:[NSString class]] && [obj isKindOfClass:[NSString class]]) {
            if (queryString.length) {
                [queryString appendString:@"&"];
            }
            [queryString appendFormat:@"%@=%@", key, obj];
        }
    }];
    return queryString;
}
@end
