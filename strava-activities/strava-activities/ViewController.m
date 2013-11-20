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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
