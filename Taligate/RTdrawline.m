//
//  RTdrawline.m
//  Restaurant
//
//  Created by Anirban Tah on 26/08/14.
//  Copyright (c) 2014 Esolz. All rights reserved.
//

#import "RTdrawline.h"

@implementation RTdrawline

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setBackgroundColor:[UIColor colorWithRed:(190.0f/255.0f) green:(190.0f/255.0f) blue:(190.0f/255.0f) alpha:1.0f]];
        pathArray = [[NSMutableArray alloc] init];
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    int count = 0;
    for(UIBezierPath *_paths in pathArray)
    {
        NSLog(@"drawww");
        
                UIColor *_color = [UIColor blackColor];
                [_color setStroke];
                [_paths strokeWithBlendMode:kCGBlendModeNormal alpha:1.0];
                count++;
                [_paths closePath];
        
        

        
        
    }
}
- (void)tapOnTable:(UIPanGestureRecognizer *)gesture {
    
    NSLog(@"tapppp");
}


#pragma mark - Touch Methods
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:self];
    if ([myPath containsPoint:touchPoint])
    {
        NSLog(@"touchhh");
    }
    if([[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"tapbar"]]  isEqual: @"Y"]){
        
        myPath=[[UIBezierPath alloc] init];
        myPath.lineWidth = 3.0f;
        
        UITouch *mytouch=[[touches allObjects] objectAtIndex:0];
        [myPath moveToPoint:[mytouch locationInView:self]];
        [pathArray addObject:myPath];
        
        
        
        
        if ([mytouch view] == self) {
            startDot = [[UIView alloc] initWithFrame:CGRectMake(([mytouch locationInView:self].x - 5.0f), ([mytouch locationInView:self].y - 5.0f), 10.0f, 10.0f)];
            [startDot setBackgroundColor:[UIColor whiteColor]];
            [startDot.layer setCornerRadius:5.0f];
            [self addSubview:startDot];
            
            endDot = [[UIView alloc] initWithFrame:CGRectMake(([mytouch locationInView:self].x - 5.0f), ([mytouch locationInView:self].y - 5.0f), 10.0f, 10.0f)];
            [endDot setBackgroundColor:[UIColor whiteColor]];
            [endDot.layer setCornerRadius:5.0f];
            [self addSubview:endDot];
        }
    }
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    // Remove the dots
    if (startDot) {
        [startDot removeFromSuperview];
        startDot = Nil;
    }
    
    if (endDot) {
        [endDot removeFromSuperview];
        endDot = Nil;
    }
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *mytouch=[[touches allObjects] objectAtIndex:0];
    [endDot setFrame:CGRectMake(([mytouch locationInView:self].x - 5.0f), ([mytouch locationInView:self].y - 5.0f), 10.0f, 10.0f)];
    
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if([[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"tapbar"]]  isEqual: @"Y"]){
        
        
        UITouch *mytouch=[[touches allObjects] objectAtIndex:0];
        [myPath addLineToPoint:[mytouch locationInView:self]];
        [pathArray addObject:myPath];
        
        
        [[NSUserDefaults standardUserDefaults] setObject:@"N" forKey:@"tapbar"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        // Remove the dots
        if (startDot) {
            //[startDot removeFromSuperview];
            startDot = Nil;
        }
        
        if (endDot) {
            //[endDot removeFromSuperview];
            endDot = Nil;
        }
        
        [self setNeedsDisplay];
    }
}



@end