//
//  UzysDragMenu.h
//  UzysDragMenu
//
//  Created by Jaehoon Jung on 13. 2. 25..
//  Copyright (c) 2013년 Uzys. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UzysDragMenuItem.h"
#import "UzysDragMenuItemView.h"
#import "UzysDragMenuControlView.h"
@interface UzysDragMenu : UIView

@property (nonatomic,strong) NSArray *pItems;
-(id)initWithItems:(NSArray *)items controlMenu:(UIView *)controlView superViewGesture:(BOOL)isSuperViewGesture showInView:(UIView *)view;

-(void)toggleMenu;
-(void)openMenu;
-(void)closeMenu;
@end
