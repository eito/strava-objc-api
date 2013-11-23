//
//  NSDictionary+STRVQueryParams.h
//  strava-objc
//
//  Created by Eric Ito on 11/22/13.
//
//

#import <Foundation/Foundation.h>

@interface NSDictionary (STRVQueryParams)

/// encodes dictionary of string key/value pairs to a query string
-(NSString*)strv_encodeStringQueryParams;

@end
