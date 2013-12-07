//
//  STRVJSONRequestOperation.m
//  strava-objc
//
//  Created by Eric Ito on 11/24/13.
//
//

#import "STRVRequestOperation.h"
#import "STRVRequestOperation+Internal.h"
#import "STRVJSONRequestOperation.h"

@implementation STRVJSONRequestOperation

-(id)processData:(NSData*)data {
    NSError *error = nil;
    id jsonObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    if (error) {
        NSLog(@"error parsing: %@", error);
        self.error = error;
        return nil;
    }
    return jsonObject;
}

@end
