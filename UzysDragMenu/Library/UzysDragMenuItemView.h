//
//  UzysSMMenuView.h
//  UzysSlideMenu
//
//  Created by Jaehoon Jung on 13. 2. 21..
//  Copyright (c) 2013년 Uzys. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UzysDragMenuItem.h"
#import <QuartzCore/QuartzCore.h>
@interface UzysDragMenuItemView : UIView<UIGestureRecognizerDelegate>

@property (strong, nonatomic) UzysDragMenuItem *item;
@property (strong, nonatomic) IBOutlet UIView *backgroundView;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UILabel *label;
@property (strong, nonatomic) IBOutlet UIView *seperatorView;

@end
