//
//  TGBecons.m
//  Taligate
//
//  Created by Soumarsi Kundu on 30/03/15.
//  Copyright (c) 2015 esolz. All rights reserved.
//

#import "TGBecons.h"

@implementation TGBecons

@synthesize TgDelegate = _TgDelegate;
@synthesize tLocked = _tLocked;
@synthesize isTLocked = _isTLocked;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        _tLocked = NO;
        _isTLocked = _tLocked;
//        RedBeconsView  = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, 40.0f, 40.0f)];
//        [RedBeconsView setBackgroundColor:[UIColor redColor]];
//        [self addSubview:RedBeconsView];
        
    }
    return self;
}
-(void)backcolor
{
    
}
- (void)configure
{
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(dragBegan:)];
    [panGesture setMaximumNumberOfTouches:2];
    [panGesture setDelegate:self];
    [self addGestureRecognizer:panGesture];
}
- (void)dragBegan:(UIPanGestureRecognizer *)gesture
{
            [_TgDelegate dragAndDrop:gesture targetView:self];
}
- (BOOL)isTLocked {
    return _isTLocked;
}
- (void)setTLocked:(BOOL)tLocked {
    _tLocked = tLocked;
    _isTLocked = _tLocked;
}
- (NSString *)ButtonLabel {
    return _ButtonLabel;
}
-(NSString *)DescriptionText
{
    return _DescriptionText;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
