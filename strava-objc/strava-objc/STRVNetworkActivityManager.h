//
//  STRVNetworkActivityManager.h
//  strava-objc
//
//  Created by Eric Ito on 11/22/13.
//
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface STRVNetworkActivityManager : NSObject

+(instancetype)manager;

-(void)show;

-(void)hide;

@end
