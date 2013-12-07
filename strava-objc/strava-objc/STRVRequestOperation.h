//
//  STRVRequestOperation.h
//  strava-objc
//
//  Created by Eric Ito on 11/24/13.
//
//

#import <Foundation/Foundation.h>

@interface STRVRequestOperation : NSOperation

/// Initialize an operation with a request.
/// Designated Initializer.
-(id)initWithRequest:(NSURLRequest*)request;

/// TODO: provide helper to get API usage statistics out of response headers
@property (nonatomic, copy) void(^responseBlock)(NSHTTPURLResponse *response, NSURLRequest *request);
@property (nonatomic, copy) void(^progressBlock)(long long downloaded, long long expectedContentlength, double percent);
@property (nonatomic, copy) void(^completionBlock)(id obj, NSError *error);

@property (nonatomic, strong, readonly) NSURLRequest *request;

/// Subclasses should override this to manipulate the returned NSData
/// JSON
/// Image
/// etc
-(id)processData:(NSData*)data;

@end
