//
//  UzysSMMenuView.m
//  UzysSlideMenu
//
//  Created by Jaehoon Jung on 13. 2. 21..
//  Copyright (c) 2013년 Uzys. All rights reserved.
//

#import "UzysDragMenuItemView.h"

@implementation UzysDragMenuItemView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [UIView animateWithDuration:0.2 animations:^{
        self.layer.backgroundColor = [UIColor colorWithRed:0.8 green:1 blue:1 alpha:0.8].CGColor;
    }];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [UIView animateWithDuration:0.2 animations:^{
        self.layer.backgroundColor = [UIColor clearColor].CGColor;
    }];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (_item.block) {
        _item.block(_item);
    }
    [UIView animateWithDuration:0.2 animations:^{
        self.layer.backgroundColor = [UIColor clearColor].CGColor;
    }];

}

-(void)setItem:(UzysDragMenuItem *)item
{
    [_item release];
    _item = [item ah_retain];
    _imageView.image = item.image;
    _label.text = item.title;
    
}
- (void)dealloc {
    [_imageView release];
    [_label release];
    [_seperatorView release];
    [_backgroundView release];
    [_item release];
    [super ah_dealloc];
}

#pragma mark - using gestureRecognizer
-(void)awakeFromNib
{
    [super awakeFromNib];
    UITapGestureRecognizer *tapGesture;
    tapGesture = [[[UITapGestureRecognizer alloc] initWithTarget:self
                                                          action:@selector(gestureTapped:)] autorelease];
    tapGesture.delegate = self;
    tapGesture.numberOfTapsRequired = 1;
    self.imageView.userInteractionEnabled = YES;
    [self.imageView addGestureRecognizer:tapGesture];
}
- (void)gestureTapped:(UIGestureRecognizer *)sender{
    if (sender.state == UIGestureRecognizerStateEnded) {
        NSLog(@"tapped");
        if (_item.block) {
            _item.block(_item);
        }
    }
}
@end
