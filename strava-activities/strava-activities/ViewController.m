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
    
    //
    // NOTE: This is unnecessary in your real apps. This is purely to avoid committing sensitive data to github.
    //       You should just set the values on STRVAPIClient directly.
    //
    //      +[STRVAPIClient setClientID:@""];
    //      +[STRVAPIClient setClientSecret:@""];
    [self loadAPIKeys];
    
    [STRVAPIClient setRedirectURI:@"http://127.0.0.1"];
    
    // For debugging...
//    [STRVAPIClient setShouldAlwaysPromptForAuthorization:YES];
    
    // create our authorization for OAuth
    STRVOAuthAuthorization *auth = [[STRVOAuthAuthorization alloc] initWithScope:STRVOAuthAccessScopeViewPrivate];

    
    // create login view
    self.authView = [[STRVOAuthView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.authView];
    [self.authView loadAuthorization:auth];
    self.authView.completion = ^(NSString *accessToken, NSError *error) {
        if (!error) {
            [STRVAPIClient setAccessToken:accessToken];
            [STRVAPIClient fetchUserActivitiesWithCompletion:^(NSArray *activities, NSError *error) {
                if (error) {
                    NSLog(@"Error retrieving activities: %@", error);
                }
                else {
                    for (STRVActivity *activity in activities) {
                        NSLog(@"Activity: %@", activity);
                    }
                }
            }];
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

-(void)loadAPIKeys {
    NSURL *clientIDURL = [[NSBundle mainBundle] URLForResource:@"clientid" withExtension:@""];
    NSURL *clientSecretURL = [[NSBundle mainBundle] URLForResource:@"clientsecret" withExtension:@""];
    
    // NOTE: In your apps, just set the STRVAPIClient defaults directly.
    //       I'm reading from a file so I don't commit my id/secret to github
    if (clientSecretURL && clientIDURL) {
        NSData *clientIDData = [NSData dataWithContentsOfURL:clientIDURL];
        NSDictionary *clientIDJSON = [NSJSONSerialization JSONObjectWithData:clientIDData options:0 error:nil];
        
        NSData *clientSecretData = [NSData dataWithContentsOfURL:clientSecretURL];
        NSDictionary *clientSecretJSON = [NSJSONSerialization JSONObjectWithData:clientSecretData options:0 error:nil];
        
        [STRVAPIClient setClientID:[clientIDJSON valueForKey:@"client_id"]];
        [STRVAPIClient setClientSecret:[clientSecretJSON valueForKey:@"client_secret"]];
    }
}

@end
