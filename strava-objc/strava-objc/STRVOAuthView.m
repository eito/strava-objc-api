//
//  STRVOAuthView.m
//  strava-objc
//
//  Created by Eric Ito on 11/22/13.
//
//

#import "STRVEnumerations.h"
#import "STRVOAuthView.h"
#import "STRVAPIClient.h"
#import "STRVOAuthAuthorization.h"
#import "STRVOAuthAuthorization+Internal.h"
#import "NSDictionary+STRVQueryParams.h"
#import "STRVNetworkActivityManager.h"

@interface STRVOAuthView ()<UIWebViewDelegate>{
    NSOperationQueue *_queue;
}
@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) STRVOAuthAuthorization *authorization;
@end

@implementation STRVOAuthView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _queue = [NSOperationQueue new];
        self.webView = [[UIWebView alloc] initWithFrame:self.bounds];
        self.webView.delegate = self;
        self.webView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        self.webView.hidden = YES;
        [self addSubview:self.webView];
    }
    return self;
}

- (void)loadAuthorization:(STRVOAuthAuthorization*)authorization {
    // cache our authorization
    self.authorization = authorization;
    
    // check if we should always prompt for authorization
    NSString *approvalPrompt = [STRVAPIClient shouldAlwaysPromptForAuthorization] ? @"force" : @"auto";
    
    NSDictionary *queryParams = @{ @"client_id" : authorization.clientID ,
                                   @"response_type" : @"code",
                                   @"redirect_uri" : authorization.redirectURI,
                                   @"scope" : NSStringFromSTRVOAuthAccessScope(authorization.scope),
                                   @"approval_prompt" : approvalPrompt };
    
    NSString *queryString = [queryParams strv_encodeStringQueryParams];
    
    NSString *requestURLString = [[authorization.URL absoluteString] stringByAppendingFormat:@"?%@", queryString];
    NSURL *requestURL = [NSURL URLWithString:requestURLString];
    [self.webView loadRequest:[NSURLRequest requestWithURL:requestURL]];
    self.webView.hidden = NO;
    
    /*
     client_id=9
     &response_type=code
     &redirect_uri=http://testapp.com/token_exchange
     &scope=write
     &state=mystate
     &approval_prompt=force
     */
}

-(NSString*)codeFromQueryString:(NSString*)queryString {
    NSArray *components = [queryString componentsSeparatedByString:@"&"];
    for (NSString *comps in components) {
        NSArray *keyValuePair = [comps componentsSeparatedByString:@"="];
        if (keyValuePair.count == 2) {
            NSString *key = keyValuePair[0];
            if ([key isEqualToString:@"code"]) {
                return keyValuePair[1];
            }
        }
    }
    return nil;
}

#pragma mark UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSURL *requestURL = [request URL];
    NSString *requestHost = [requestURL host];
    if (requestHost && [self.authorization.redirectURI rangeOfString:requestHost].length) {
        // this redirect is the auth callback
        //
        NSString *queryString = [requestURL query];
        
        // set our STRVOAuthAuthorization's code here...
        NSString *code = [self codeFromQueryString:queryString];
        self.authorization.authorizationCode = code;
        self.webView.hidden = YES;
        NSDictionary *queryParams = @{ @"client_id" : self.authorization.clientID,
                                       @"code" : self.authorization.authorizationCode,
                                       @"client_secret" : self.authorization.clientSecret };
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[STRVAPIClient tokenURL]];
        [request setHTTPMethod:@"POST"];
        NSString *postString = [queryParams strv_encodeStringQueryParams];
        [request setHTTPBody:[postString dataUsingEncoding:NSUTF8StringEncoding]];
        
        // show activity indicator
        [[STRVNetworkActivityManager manager] show];
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:_queue
                               completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                                   NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data
                                                                                        options:0
                                                                                          error:nil];
                                   NSString *accessToken = [json valueForKey:@"access_token"];
                                   self.completion(accessToken, connectionError);

                                   // hide network activity indicator
                                   [[STRVNetworkActivityManager manager] hide];
                               }];
        [webView stopLoading];
        return NO;
    }
    return YES;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    // ignore the following error
    // we get this when we stop loading the redirect to the redirectURI
    if ([error code] != 102) {
        [webView stopLoading];
        self.completion(nil, error);
    }
}

@end
