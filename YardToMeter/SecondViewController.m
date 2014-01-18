//
//  SecondViewController.m
//  YardToMeter
//
//  Created by Dunkey on 2014. 1. 17..
//  Copyright (c) 2014년 Dunkey. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	[self.navigationController.navigationBar setTintColor:[UIColor redColor]];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)onClose:(id)sender {
	[self.navigationController dismissViewControllerAnimated:YES completion:nil];
}
@end
