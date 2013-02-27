//
//  UzysViewController.m
//  UzysDragMenu
//
//  Created by Jaehoon Jung on 13. 2. 25..
//  Copyright (c) 2013년 Uzys. All rights reserved.
//

#import "UzysViewController.h"
#import "UzysDragMenu.h"

@interface UzysViewController ()
@property (nonatomic,strong) UzysDragMenu *uzysDmenu;
@end

@implementation UzysViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    CGRect frame = [UIScreen mainScreen].applicationFrame;
    self.view.frame = frame;
    
    //*******Icons from http://glyphicons.com/ ***********
    UzysDragMenuItem *item0 = [[UzysDragMenuItem alloc] initWithTitle:@"UzysDrag Menu" image:[UIImage imageNamed:@"0.png"] action:^(UzysDragMenuItem *item) {
        NSLog(@"Item: %@", item);

    }];
    UzysDragMenuItem *item1 = [[UzysDragMenuItem alloc] initWithTitle:@"Favorite" image:[UIImage imageNamed:@"1.png"] action:^(UzysDragMenuItem *item) {
        NSLog(@"Item: %@", item);

    }];
    UzysDragMenuItem *item2 = [[UzysDragMenuItem alloc] initWithTitle:@"Search" image:[UIImage imageNamed:@"2.png"] action:^(UzysDragMenuItem *item) {
        
 
        NSLog(@"Item: %@", item);
    }];
    item0.tag = 0;
    item1.tag = 1;
    item2.tag = 2;
    
    UzysDragMenuControlView *controlView = [[[NSBundle mainBundle] loadNibNamed:@"UzysDragMenuControlView" owner:self options:nil] lastObject];
    
    [controlView.btnAction addTarget:self action:@selector(actionBtn:) forControlEvents:UIControlEventTouchUpInside];
    self.uzysDmenu = [[UzysDragMenu alloc] initWithItems:@[item0,item1,item2]
                                             controlMenu:controlView
                                        superViewGesture:YES];
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
