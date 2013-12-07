//
//  STRVRequestOperation.m
//  strava-objc
//
//  Created by Eric Ito on 11/24/13.
//
//

#import "STRVRequestOperation.h"
#import "STRVNetworkActivityManager.h"


@interface STRVRequestOperation ()<NSURLConnectionDataDelegate, NSURLConnectionDelegate> {
    BOOL _executing;
    BOOL _finished;
}
@property (nonatomic, strong) NSURLConnection *connection;
@property (nonatomic, strong, readwrite) NSURLRequest *request;
@property (nonatomic, strong) NSMutableData *responseData;
@property (nonatomic, assign) long long expectedContentLength;
@property (nonatomic, strong) NSError *error;
@property (nonatomic, strong) id result;
@end

@implementation STRVRequestOperation

-(id)initWithRequest:(NSURLRequest *)request {
    self = [super init];
    if (self) {
        self.request = request;
    }
    return self;
}

-(id)processData:(NSData*)data {
    return data;
}

#pragma mark Overrides

-(void)cancel {
    NSLog(@"cancelling");
    [super cancel];
    [self.connection cancel];
    if ([self isExecuting]) {
        [self willChangeValueForKey:@"isExecuting"];
        _executing = NO;
        [self didChangeValueForKey:@"isExecuting"];
        [self willChangeValueForKey:@"isFinished"];
        _finished = YES;
        [self didChangeValueForKey:@"isFinished"];
    }
}


-(void)start {

    if ([self isCancelled]) {
        [self done];
        return;
    }
    
    [self willChangeValueForKey:@"isExecuting"];
    _executing = YES;
    [self didChangeValueForKey:@"isExecuting"];
    [self willChangeValueForKey:@"isFinished"];
    _finished = NO;
    [self didChangeValueForKey:@"isFinished"];

    [[STRVNetworkActivityManager manager] show];

    // create our connection and kick it off
    self.connection = [NSURLConnection connectionWithRequest:self.request delegate:self];
    
    // Here is the trick -- as of iOS 4, operations are started on a bg thread
    NSPort* port = [NSPort port];
    NSRunLoop* rl = [NSRunLoop currentRunLoop]; // Get the runloop
    [rl addPort:port forMode:NSDefaultRunLoopMode];
    [self.connection scheduleInRunLoop:rl forMode:NSDefaultRunLoopMode];
    //[self.connection start];
    [rl run];
}

-(void)done {
    
    [[STRVNetworkActivityManager manager] hide];
    
    if (self.completionBlock && ![self isCancelled]) {
        if (!self.error) {
            self.result = [self processData:self.responseData];
        }
        self.completionBlock(self.result, self.error);
    }
    
    self.connection = nil;
    
    [self willChangeValueForKey:@"isExecuting"];
    _executing = NO;
    [self didChangeValueForKey:@"isExecuting"];
    [self willChangeValueForKey:@"isFinished"];
    _finished = YES;
    [self didChangeValueForKey:@"isFinished"];
}

-(BOOL)isFinished {
    return _finished || [self isCancelled];
}

-(BOOL)isExecuting {
    return _executing;
}

-(BOOL)isConcurrent {
    return YES;
}

-(void)dealloc {
    NSLog(@"dealloc");
}

#pragma mark NSURLConnectionDelegate

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"Connection error: %@", error);
    self.error = error;
    [self done];
}

#pragma mark NSURLConnectionDataDelegate

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    /*
     "X-RateLimit-Limit" = "600,30000";
     "X-RateLimit-Usage" = "2,2";
     "Strava-Athlete-Upload-Version" = eb9910b648821892c45be04f29013639;
     
     */
    
    //
    // check if we are cancelled
    if ([self isCancelled]) {
        [self.connection cancel];
        [self done];
        return;
    }
    
    if (self.responseBlock) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.responseBlock((NSHTTPURLResponse*)response, self.request);
        });
    }
    
    if (self.progressBlock) {
        if ([response expectedContentLength] != NSURLResponseUnknownLength) {
            self.expectedContentLength = [response expectedContentLength];
            dispatch_async(dispatch_get_main_queue(), ^{
                self.progressBlock(0, self.expectedContentLength, 0.0);
            });
        }
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    
    //
    // check if we are cancelled
    if ([self isCancelled]) {
        [self.connection cancel];
        [self done];
        return;
    }
    
    // append our data from the connection
    if (!self.responseData.length) {
        self.responseData = [NSMutableData data];
    }
    [self.responseData appendData:data];
    
    // callback with progress of download
    if (self.progressBlock) {
        double percent = 0.0;
        if (self.expectedContentLength > 0) {
            percent = (double)(data.length) / self.expectedContentLength;
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            self.progressBlock(self.responseData.length, self.expectedContentLength, percent);
        });
    }
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    
    //
    // check if we are cancelled
    if ([self isCancelled]) {
        [self.connection cancel];
        [self done];
        return;
    }
    
    // update progress
    if (self.progressBlock) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.progressBlock(self.responseData.length, self.expectedContentLength, 1.0);
        });
    }
    
    [self done];
}

@end
