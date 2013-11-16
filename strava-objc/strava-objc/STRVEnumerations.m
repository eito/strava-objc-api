//
//  STRVEnumerations.m
//  strava-objc
//
//  Created by Eric Ito on 11/16/13.
//
//

#import "STRVEnumerations.h"

#pragma mark STRVGender

static NSArray *kSTRVGenderStrings = nil;

NSArray *STRVGenderStrings() {
    if (!kSTRVGenderStrings) {
        kSTRVGenderStrings = @[@"M", @"F"];
    }
    return kSTRVGenderStrings;
}

STRVGender STRVGenderFromString(NSString *gender)
{
    return (STRVGender)[STRVGenderStrings() indexOfObject:gender];
}

NSString *NSStringFromSTRVGender(STRVGender gender)
{
    if (gender == STRVGenderUnspecified) {
        return nil;
    }
    else {
        return [STRVGenderStrings() objectAtIndex:gender];
    }
}

#pragma mark STRVActivityType

static NSArray *kSTRVActivityTypeStrings = nil;

NSArray *STRVActivityTypeStrings() {
    if (!kSTRVActivityTypeStrings) {
        kSTRVActivityTypeStrings = @[@"Ride", @"Run"];
    }
    return kSTRVActivityTypeStrings;
}

STRVActivityType STRVActivityTypeFromString(NSString *activityType)
{
    return [STRVActivityTypeStrings() indexOfObject:activityType];
}

NSString *NSStringFromSTRVActivityType(STRVActivityType activityType)
{
    return [STRVActivityTypeStrings() objectAtIndex:activityType];
}

#pragma mark STRVRequestStatus

static NSArray *kSTRVRequestStatusStrings = nil;

NSArray *STRVRequestStatusStrings() {
    if (!kSTRVRequestStatusStrings) {
        kSTRVRequestStatusStrings = @[@"pending", @"accepted", @"blocked"];
    }
    return kSTRVRequestStatusStrings;
}

STRVRequestStatus STRVRequestStatusFromString(NSString *status)
{
    return [STRVRequestStatusStrings() indexOfObject:status];
}

NSString *NSStringFromSTRVRequestStatus(STRVRequestStatus status)
{
    if (status == STRVRequestStatusNone) {
        return nil;
    }
    return [STRVRequestStatusStrings() objectAtIndex:status];
}