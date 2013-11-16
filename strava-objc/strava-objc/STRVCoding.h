//
//  STRVCoding.h
//  strava-objc
//
//  Created by Eric Ito on 11/15/13.
//
//

#import <Foundation/Foundation.h>

@protocol STRVCoding <NSObject>

-(id)initWithJSON:(NSDictionary*)json;
-(NSDictionary*)encodeToJSON;

@end
