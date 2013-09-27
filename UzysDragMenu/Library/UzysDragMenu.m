//
//  UzysDragMenu.m
//  UzysDragMenu
//
//  Created by Jaehoon Jung on 13. 2. 25..
//  Copyright (c) 2013년 Uzys. All rights reserved.
//

#import "UzysDragMenu.h"

@interface UzysDragMenu()
@property (nonatomic,strong) NSMutableArray *itemViews;
@property (nonatomic,strong) UIView *controlView;
@property (nonatomic,assign) CGRect openFrame;
@property (nonatomic,assign) CGRect closeFrame;
@property (nonatomic,assign) BOOL isSuperViewGesture;
@property (nonatomic,assign) UIView *showInView;
-(void)setupLayout;
-(void)setupGesture;
@end

@implementation UzysDragMenu

-(id)initWithItems:(NSArray *)items controlMenu:(UIView *)controlView superViewGesture:(BOOL)isSuperViewGesture showInView:(UIView *)view
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
        [self setupLayout];
        [self setupGesture];
        
    }
    return self;
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
-(void)setupLayout
{
    [self.itemViews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [obj removeFromSuperview];
    }];
    [self.itemViews removeAllObjects];
    [self.controlView removeFromSuperview];
    
    
    UzysDragMenuItemView *itemView = [[[NSBundle mainBundle] loadNibNamed:@"UzysDragMenuItemView" owner:self options:nil] lastObject];
    CGFloat menuHeight =itemView.bounds.size.height * ([_pItems count]+1) + self.controlView.bounds.size.height;
    CGFloat menuWidth = itemView.bounds.size.width;
    CGFloat menuYPos = itemView.bounds.size.height * ([_pItems count]+1) ;
    
    CGFloat superHeight;
    if(self.superview)
        superHeight = self.superview.bounds.size.height;
    else
        superHeight = self.showInView.bounds.size.height;
    NSLog(@"height %f",superHeight);
    self.closeFrame = CGRectMake(0, superHeight - self.controlView.bounds.size.height, menuWidth, menuHeight);
    self.openFrame = CGRectMake(0, superHeight - menuYPos, menuWidth, menuHeight);
    [self setFrame:self.closeFrame];
    
    
    for( int i=0; i<[self.pItems count]; i++)
    {
        UzysDragMenuItemView *itemView = [[[NSBundle mainBundle] loadNibNamed:@"UzysDragMenuItemView" owner:self options:nil] lastObject];
        itemView.item = self.pItems[i];
        itemView.frame = CGRectMake(0, self.controlView.bounds.size.height + itemView.bounds.size.height*i, itemView.bounds.size.width, itemView.bounds.size.height);
        itemView.userInteractionEnabled = YES;
        itemView.tag = itemView.item.tag;
        
        [self addSubview:itemView];
        [self sendSubviewToBack:itemView];
        [self.itemViews addObject:itemView];
//        NSLog(@"itemView Frame %@",NSStringFromCGRect(itemView.frame));
    }
    
    
    self.controlView.frame = CGRectMake(0, 0, self.controlView.bounds.size.width, self.controlView.bounds.size.height);
    [self addSubview:self.controlView];
//    NSLog(@"UzysDMenu Frame %@",NSStringFromCGRect(self.frame));
//    NSLog(@"UzysControlView Frame %@",NSStringFromCGRect(self.controlView.frame));
    
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
