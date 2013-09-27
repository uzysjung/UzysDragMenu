//
//  UzysViewController.m
//  UzysDragMenu
//
//  Created by Jaehoon Jung on 13. 2. 25..
//  Copyright (c) 2013년 Uzys. All rights reserved.
//

#import "UzysViewController.h"
#import "UzysDragMenu.h"

#define IS_IOS7 [[[UIDevice currentDevice] systemVersion] floatValue] >= 7

@interface UzysViewController ()
@property (nonatomic,strong) UzysDragMenu *uzysDmenu;
@end

@implementation UzysViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    CGRect frame;
    if(IS_IOS7)
    {
        frame = [UIScreen mainScreen].bounds;
    }
    else
    {
        frame = [UIScreen mainScreen].applicationFrame;
    }
    self.view.frame = frame;
    
    //*******Icons from http://adamwhitcroft.com/climacons/ ***********
    UzysDragMenuItem *item0 = [[UzysDragMenuItem alloc] initWithTitle:@"UzysDrag Menu" image:[UIImage imageNamed:@"a0.png"] action:^(UzysDragMenuItem *item) {
        NSLog(@"Item: %@", item);

    }];
    UzysDragMenuItem *item1 = [[UzysDragMenuItem alloc] initWithTitle:@"Favorite" image:[UIImage imageNamed:@"a1.png"] action:^(UzysDragMenuItem *item) {
        NSLog(@"Item: %@", item);

    }];
    UzysDragMenuItem *item2 = [[UzysDragMenuItem alloc] initWithTitle:@"Search" image:[UIImage imageNamed:@"a2.png"] action:^(UzysDragMenuItem *item) {
        
 
        NSLog(@"Item: %@", item);
    }];
    item0.tag = 0;
    item1.tag = 1;
    item2.tag = 2;
    
    UzysDragMenuControlView *controlView = [[[NSBundle mainBundle] loadNibNamed:@"UzysDragMenuControlView" owner:self options:nil] lastObject];
    
    [controlView.btnAction addTarget:self action:@selector(actionBtn:) forControlEvents:UIControlEventTouchUpInside];
    self.uzysDmenu = [[UzysDragMenu alloc] initWithItems:@[item0,item1,item2]
                                             controlMenu:controlView
                                        superViewGesture:YES showInView:self.view];
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
