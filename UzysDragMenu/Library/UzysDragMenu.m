//
//  UzysDragMenu.m
//  UzysDragMenu
//
//  Created by Jaehoon Jung on 13. 2. 25..
//  Copyright (c) 2013년 Uzys. All rights reserved.
//

#import "UzysDragMenu.h"
#import <QuartzCore/QuartzCore.h>

@interface UzysDragMenu()
@property (nonatomic,strong) NSMutableArray *itemViews;
@property (nonatomic,strong) UIView *controlView;
@property (nonatomic,strong) UIView *menuView;
@property (nonatomic,assign) CGRect openFrame;
@property (nonatomic,assign) CGRect closeFrame;
@property (nonatomic,assign) BOOL isSuperViewGesture;
@property (nonatomic,assign) UIView *showInView;
-(void)setupLayout;
-(void)setupGesture;
@end

@implementation UzysDragMenu

// Designated initializer
- (id)initWithItems:(NSArray *)items menuView:(UIView *)menuView controlMenu:(UIView *)controlView superViewGesture:(BOOL)isSuperViewGesture showInView:(UIView *)view
{
    self = [super init];
    if(self)
    {
        //Initialization code
        self.userInteractionEnabled = YES;
        self.pItems = items;
        self.itemViews = [NSMutableArray array];
        self.controlView = controlView;
        self.isSuperViewGesture = isSuperViewGesture;
        self.showInView = view;
        self.menuView = menuView;
        [self setupLayout];
        [self setupGesture];
        
    }
    return self;
}

-(id)initWithItems:(NSArray *)items controlMenu:(UIView *)controlView superViewGesture:(BOOL)isSuperViewGesture showInView:(UIView *)view
{
    return [self initWithItems:items menuView:nil controlMenu:controlView superViewGesture:isSuperViewGesture showInView:view];
}

-(id)initWithMenuView:(UIView *)menuView controlMenu:(UIView *)controlView superViewGesture:(BOOL)isSuperViewGesture showInView:(UIView *)view
{
    return [self initWithItems:nil menuView:menuView controlMenu:controlView superViewGesture:isSuperViewGesture showInView:view];
}

-(void)dealloc
{
    [_pItems release];
    [_controlView release];
    [_itemViews release];
    [super ah_dealloc];
}



-(void)setupGesture
{
    UIPanGestureRecognizer *panGestureRecognizer = [[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureAction:)] autorelease];
    panGestureRecognizer.maximumNumberOfTouches = 1;
    panGestureRecognizer.minimumNumberOfTouches = 1;
    [self addGestureRecognizer:panGestureRecognizer];
    if(self.isSuperViewGesture)
    {
        if(self.superview)
            [self.superview addGestureRecognizer:panGestureRecognizer];
        else
            [self.showInView addGestureRecognizer:panGestureRecognizer];
        
    }
    
}

- (UIView *)buildMenuView
{
    CGFloat menuHeight, menuWidth, itemHeight;
    int numItems;
    UzysDragMenuItemView *tempItemView = [[[NSBundle mainBundle] loadNibNamed:@"UzysDragMenuItemView" owner:self options:nil] lastObject];
    itemHeight = tempItemView.bounds.size.height;
    menuWidth = tempItemView.bounds.size.width;
    numItems = self.pItems.count;
    menuHeight = (CGFloat)numItems * itemHeight;
    
    // Remove existing views
    [self.itemViews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [obj removeFromSuperview];
    }];
    [self.itemViews removeAllObjects];
    
    CGRect menuFrame = CGRectMake(0, 0, menuWidth, menuHeight);
    UIView *menuHolder = [[UIView alloc] initWithFrame:menuFrame];
    CGRect itemFrame = CGRectMake(0, 0, menuWidth, itemHeight);
    for (int i = 0; i < numItems; i++)
    {
        UzysDragMenuItemView *itemView = [[[NSBundle mainBundle] loadNibNamed:@"UzysDragMenuItemView" owner:self options:nil] lastObject];
        itemView.item = self.pItems[i];
        itemView.frame = itemFrame;
        itemView.userInteractionEnabled = YES;
        itemView.tag = itemView.item.tag;
        [menuHolder addSubview:itemView];
        [self.itemViews addObject:itemView];
        [menuHolder addSubview:itemView];
        [menuHolder sendSubviewToBack:itemView];
        
        itemFrame.origin.y += itemHeight;
    }
    
    return menuHolder;
}

-(void)setupLayout
{
    UIView *actualMenuView;
    CGRect menuFrame;
    CGFloat menuHeight, menuWidth;
    CGRect controlFrame = self.controlView.bounds;
    CGFloat controlHeight = controlFrame.size.height;
    
    [self.controlView removeFromSuperview];
    
    if (self.menuView) {
        actualMenuView = self.menuView;
    } else {
        actualMenuView = [self buildMenuView];
    }
    actualMenuView.autoresizingMask = UIViewAutoresizingNone;
    
    menuFrame = actualMenuView.frame;
    menuHeight = menuFrame.size.height;
    menuWidth = menuFrame.size.width;
    
    CGFloat superHeight;
    if(self.superview)
        superHeight = self.superview.bounds.size.height;
    else
        superHeight = self.showInView.bounds.size.height;
    
    self.closeFrame = CGRectMake(0, superHeight - controlHeight, menuWidth, menuHeight);
    self.openFrame = CGRectMake(0, superHeight - controlHeight - menuHeight, menuWidth, menuHeight + controlHeight);
    
    [self setFrame:self.closeFrame];
    
    menuFrame.origin.y = controlHeight;
    actualMenuView.frame = menuFrame;
    [self addSubview:actualMenuView];
    [self sendSubviewToBack:actualMenuView];
    
    controlFrame.origin = CGPointMake(0, 0);
    self.controlView.frame = controlFrame;
    [self addSubview:self.controlView];
}


#pragma mark - menu

-(void)toggleMenu
{
    if(CGRectEqualToRect(self.frame, self.openFrame))
    {
        [self closeMenu];
    }
    else
    {
        [self openMenu];
    }
}
-(void)openMenu
{
    [UIView animateWithDuration:0.1f delay:0.0f options:UIViewAnimationOptionAllowUserInteraction|UIViewAnimationOptionBeginFromCurrentState|UIViewAnimationOptionCurveEaseOut animations:^{
        
        self.frame = self.openFrame;
    } completion:^(BOOL finished) {
    }];
}
-(void)closeMenu
{
    [UIView animateWithDuration:0.1f delay:0.0f options:UIViewAnimationOptionAllowUserInteraction|UIViewAnimationOptionBeginFromCurrentState|UIViewAnimationOptionCurveEaseOut animations:^{
        
        self.frame = self.closeFrame;
    } completion:^(BOOL finished) {
        
    }];
}

#pragma mark - Gesture Recognizer
- (void)panGestureAction:(UIPanGestureRecognizer *)recognizer
{
    if( ([recognizer state] == UIGestureRecognizerStateBegan) ||
       ([recognizer state] == UIGestureRecognizerStateChanged) )
    {
        CGPoint movement = [recognizer translationInView:self.superview];
        CGRect old_rect = self.frame;
        
        old_rect.origin.y = old_rect.origin.y + movement.y;
        if(old_rect.origin.y < self.openFrame.origin.y)
        {
            self.frame = self.openFrame;
        }
        else if(old_rect.origin.y > self.closeFrame.origin.y)
        {
            self.frame = self.closeFrame;
        }
        else
        {
            self.frame = old_rect;
        }
        
        [recognizer setTranslation:CGPointZero inView:self.superview];
    }
    else if(recognizer.state == UIGestureRecognizerStateEnded || recognizer.state == UIGestureRecognizerStateCancelled)
    {
        CGFloat halfPoint = (self.closeFrame.origin.y + self.openFrame.origin.y)/ 2;
        if(self.frame.origin.y > halfPoint)
        {
            [self closeMenu];
        }
        else
        {
            [self openMenu];
        }
    }
    
}

@end
