//
//  STRVAthlete.m
//  strava-objc
//
//  Created by Eric Ito on 11/16/13.
//
//

#import "STRVCoding.h"
#import "STRVEnumerations.h"
#import "STRVAthlete.h"
#import "STRVUtility.h"
#import "STRVClub.h"
#import "STRVBike.h"
#import "STRVShoe.h"

@interface STRVAthlete ()
@property (nonatomic, assign, readwrite) NSUInteger athleteID;
@property (nonatomic, assign, readwrite) NSUInteger resourceState; // enum
@property (nonatomic, copy, readwrite) NSString *firstName;
@property (nonatomic, copy, readwrite) NSString *lastName;
@property (nonatomic, strong, readwrite) NSURL *profileImageMedURL;
@property (nonatomic, strong, readwrite) NSURL *profileImageURL;
@property (nonatomic, copy, readwrite) NSString *city;
@property (nonatomic, copy, readwrite) NSString *state;
@property (nonatomic, assign, readwrite) STRVGender gender;
@property (nonatomic, assign, readwrite) STRVRequestStatus friendStatus;
@property (nonatomic, assign, readwrite) STRVRequestStatus followerStatus;
@property (nonatomic, assign, readwrite) BOOL premium;
@property (nonatomic, strong, readwrite) NSDate *creationDate;
@property (nonatomic, strong, readwrite) NSDate *modifiedDate;
@property (nonatomic, assign, readwrite) BOOL approveFollowers;
@property (nonatomic, assign, readwrite) NSUInteger followerCount;
@property (nonatomic, assign, readwrite) NSUInteger friendCount;
@property (nonatomic, assign, readwrite) NSUInteger mutualFriendCount;
@property (nonatomic, strong, readwrite) NSArray *clubs;
@property (nonatomic, strong, readwrite) NSArray *bikes;
@property (nonatomic, strong, readwrite) NSArray *shoes;
@end

@implementation STRVAthlete

#pragma mark STRVCoding


-(id)initWithJSON:(NSDictionary *)json {
    self = [self init];
    if (self) {
        self.athleteID = [json[@"id"] unsignedIntegerValue];
        self.resourceState = [json[@"resource_state"] unsignedIntegerValue];
        self.firstName = json[@"firstname"];
        self.lastName = json[@"lastname"];
        self.profileImageMedURL = [NSURL URLWithString:json[@"profile_medium"]];
        self.profileImageURL = [NSURL URLWithString:json[@"profile"]];
        self.city = json[@"city"];
        self.state = json[@"state"];
        self.gender = STRVGenderFromString([json valueForKey:@"sex"]);
        self.friendStatus = STRVRequestStatusFromString([json valueForKey:@"friend"]);
        self.followerStatus = STRVRequestStatusFromString([json valueForKey:@"follower"]);
        self.premium = [[json valueForKey:@"premium"] boolValue];
        NSDateFormatter *df = [[STRVUtility sharedInstance] dateFormatter];
        self.creationDate = [df dateFromString:[json valueForKey:@"created_at"]];
        self.modifiedDate = [df dateFromString:[json valueForKey:@"updated_at"]];
        self.approveFollowers = [json[@"approve_followers"] boolValue];
        self.followerCount = [json[@"follower_count"] unsignedIntegerValue];
        self.friendCount = [json[@"friend_count"] unsignedIntegerValue];
        self.mutualFriendCount = [json[@"mutual_friend_count"] unsignedIntegerValue];
        self.clubs = [STRVUtility decodeArrayFromJSON:json withKey:@"clubs" class:[STRVClub class]];
        self.bikes = [STRVUtility decodeArrayFromJSON:json withKey:@"bikes" class:[STRVBike class]];
        self.shoes = [STRVUtility decodeArrayFromJSON:json withKey:@"shoes" class:[STRVShoe class]];
        
        /*
         {
         "id": 227615,
         "resource_state": 3,
         "firstname": "John",
         "lastname": "Applestrava",
         "profile_medium": "http://pics.com/227615/medium.jpg",
         "profile": "http://pics.com/227615/large.jpg",
         "city": "San Francisco",
         "state": "California",
         "sex": "M",
         "friend": null,
         "follower": null,
         "premium": true,
         "created_at": "2008-01-01T17:44:00Z",
         "updated_at": "2013-09-04T20:00:50Z",
         "follower_count": 273,
         "friend_count": 19,
         "mutual_friend_count": 0,
         "date_preference": "%m/%d/%Y",
         "measurement_preference": "feet",
         "clubs": [
         {
         "id": 1,
         "resource_state": 2,
         "name": "Team Strava Cycling"
         }
         ],
         "bikes": [
         {
         "id": "b105763",
         "primary": false,
         "name": "Cannondale TT",
         "distance": 476612.8984375,
         "resource_state": 2
         },
         {
         "id": "b105762",
         "primary": true,
         "name": "Masi",
         "distance": 9000578.200805664,
         "resource_state": 2
         }
         ],
         "shoes": [
         {
         "id": "g1",
         "primary": true,
         "name": "Running Shoes",
         "distance": 67492.94833374023,
         "resource_state": 2
         }
         ]
         }
         */
    }
    return self;
}

-(NSDictionary *)encodeToJSON {
    return nil;
}
@end
