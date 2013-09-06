//
//  UzysCustomViewController.m
//  UzysDragMenu
//
//  Created by Mike Matz on 9/5/13.
//  Copyright (c) 2013 Uzys. All rights reserved.
//

#import "UzysCustomViewController.h"
#import "UzysDragMenu.h"

@interface UzysCustomViewController ()
@property (nonatomic,strong) UzysDragMenu *uzysDmenu;
@end

@implementation UzysCustomViewController

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
	// Do any additional setup after loading the view, typically from a nib.
    
    CGRect frame = [UIScreen mainScreen].applicationFrame;
    self.view.frame = frame;
    
    UzysDragMenuControlView *controlView = [[[NSBundle mainBundle] loadNibNamed:@"UzysDragMenuControlView" owner:self options:nil] lastObject];
    [controlView.btnAction addTarget:self action:@selector(actionBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *customView;
    if (true) {
        customView = [[[NSBundle mainBundle] loadNibNamed:@"CustomMenuView" owner:self options:nil] lastObject];
    } else {
        CGRect f = self.view.bounds;
        f.size.height = 200;
        customView = [[UIView alloc] initWithFrame:f];
        customView.backgroundColor = [UIColor yellowColor];
    }
    
    self.uzysDmenu = [[UzysDragMenu alloc] initWithMenuView:customView controlMenu:controlView superViewGesture:YES showInView:self.view];
    [self.view addSubview:self.uzysDmenu];
}

-(IBAction)actionBtn:(id)sender
{
    [self.uzysDmenu toggleMenu];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
