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
    STRVAthlete *ath = [[STRVAthlete alloc] init];
    NSLog(@"%@", ath);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
