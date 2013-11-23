//
//  ViewController.m
//  strava-activities
//
//  Created by Eric Ito on 11/15/13.
//
//

#import "ViewController.h"
#import "Strava.h"

@interface ViewController ()
@property (nonatomic, strong) STRVOAuthView *authView;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    NSURL *fileURL = [[NSBundle mainBundle] URLForResource:@"sample_activity" withExtension:@"json"];
    NSInputStream *is = [[NSInputStream alloc] initWithURL:fileURL];
    [is open];
    NSDictionary *json = [NSJSONSerialization JSONObjectWithStream:is options:0 error:nil];
    [is close];
    STRVActivity *activity = [[STRVActivity alloc] initWithJSON:json];
    NSLog(@"%@", activity);
    
    
    // create our authorization for OAuth
    STRVOAuthAuthorization *auth = [STRVOAuthAuthorization new];
    
    //
    // NOTE: This is unnecessary in your real apps. This is purely to avoid committing sensitive data to github.
    //
    NSURL *clientIDURL = [[NSBundle mainBundle] URLForResource:@"clientid" withExtension:@""];
    NSData *clientIDData = [NSData dataWithContentsOfURL:clientIDURL];
    NSDictionary *clientIDJSON = [NSJSONSerialization JSONObjectWithData:clientIDData options:0 error:nil];
    NSURL *clientSecretURL = [[NSBundle mainBundle] URLForResource:@"clientsecret" withExtension:@""];
    NSData *clientSecretData = [NSData dataWithContentsOfURL:clientSecretURL];
    NSDictionary *clientSecretJSON = [NSJSONSerialization JSONObjectWithData:clientSecretData options:0 error:nil];
    
    // NOTE: In your apps, just set the STRVAPIClient defaults directly.
    //       I'm reading from a file so I don't commit my id/secret to github
    [STRVAPIClient setClientID:[clientIDJSON valueForKey:@"client_id"]];
    [STRVAPIClient setClientSecret:[clientSecretJSON valueForKey:@"client_secret"]];

    auth.clientID = [STRVAPIClient clientID];
    auth.clientSecret = [STRVAPIClient clientSecret];
    
    auth.redirectURI = @"http://127.0.0.1";
    auth.scope = STRVOAuthAccessScopeViewPrivate;
    
    // create login view
    self.authView = [[STRVOAuthView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.authView];
    [self.authView loadAuthorization:auth];
    self.authView.completion = ^(NSString *accessToken, NSError *error) {
        if (!error) {
            [STRVAPIClient setAccessToken:accessToken];
        }
        else {
            // TODO: Do something better when things go wrong.
            UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"OAuth Error"
                                                         message:[error localizedDescription]
                                                        delegate:nil
                                               cancelButtonTitle:@"OK"
                                               otherButtonTitles: nil];
            [av show];
        }
    };
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
