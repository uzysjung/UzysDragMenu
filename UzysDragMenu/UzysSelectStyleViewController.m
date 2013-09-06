//
//  UzysSelectStyleViewController.m
//  UzysDragMenu
//
//  Created by Mike Matz on 9/5/13.
//  Copyright (c) 2013 Uzys. All rights reserved.
//

#import "UzysSelectStyleViewController.h"
#import "UzysViewController.h"
#import "UzysCustomViewController.h"

@interface UzysSelectStyleViewController ()

@end

@implementation UzysSelectStyleViewController

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
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)selectStandard:(id)sender {
    UzysViewController *vc = [[UzysViewController alloc] initWithNibName:@"UzysViewController" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)selectCustom:(id)sender {
    UzysCustomViewController *vc = [[UzysCustomViewController alloc] initWithNibName:@"UzysViewController" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
