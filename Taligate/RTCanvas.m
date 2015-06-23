//
//  RTCanvas.m
//  Restaurant
//
//  Created by Soumalya Banerjee on 6/13/14.
//  Copyright (c) 2014 Esolz. All rights reserved.
//

#import "RTCanvas.h"
#import "IQGeometry.h"

@implementation RTCanvas

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        //        [self setBackgroundColor:[UIColor clearColor]];
        //        pathArray = [[NSMutableArray alloc] init];
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{

//    for (NSArray* lineValue1 in _lines)
//    {
        for (NSValue *lineValue in _lines) {
            IQLine line = [lineValue lineValue];
            
            CGContextRef context = UIGraphicsGetCurrentContext();
            CGContextSaveGState                 (context);
            CGContextSetStrokeColorWithColor    (context, [[UIColor whiteColor]CGColor]);
            CGContextSetLineWidth               (context, 1.0);
            CGContextMoveToPoint                (context, line.beginPoint.x, line.beginPoint.y);
            CGContextAddLineToPoint             (context, line.endPoint.x, line.endPoint.y);
            CGContextStrokePath                 (context);
            CGContextRestoreGState              (context);
        //}
        
    }
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    //    CGContextSaveGState                 (context);
    
    CGFloat beginAngle = IQPointGetAngle(_centerPoint, CGPointMake(_centerPoint.x+10, _centerPoint.y), _startPoint);
    CGFloat endAngle = IQPointGetAngle(_centerPoint, CGPointMake(_centerPoint.x+10, _centerPoint.y), _endPoint);
    CGFloat radius = IQPointGetDistance(_centerPoint, _startPoint);
    
    CGContextAddArc(context,
                    _centerPoint.x,
                    _centerPoint.y,
                    radius,
                    beginAngle,
                    endAngle,
                    0);
    
    //    CGContextMoveToPoint(context, _centerPoint.x, _centerPoint.y);
    //
    //    CGContextAddLineToPoint(context, _centerPoint.x, _centerPoint.y);
    //
    //    CGContextAddArcToPoint(context,100,100,200,100,30);
    //
    //    CGContextAddLineToPoint(context, _centerPoint.x, _centerPoint.y);
    CGContextStrokePath(context);
    //    CGContextRestoreGState              (context);
    
}

#pragma mark - Touch Methods
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //    myPath=[[UIBezierPath alloc] init];
    //    myPath.lineWidth = 3.0f;
    //
    //    UITouch *mytouch=[[touches allObjects] objectAtIndex:0];
    //    [myPath moveToPoint:[mytouch locationInView:self]];
    //    [pathArray addObject:myPath];
    //
    //    if ([mytouch view] == self) {
    //        startDot = [[UIView alloc] initWithFrame:CGRectMake(([mytouch locationInView:self].x - 5.0f), ([mytouch locationInView:self].y - 5.0f), 10.0f, 10.0f)];
    //        [startDot setBackgroundColor:[UIColor whiteColor]];
    //        [startDot.layer setCornerRadius:5.0f];
    //        [self addSubview:startDot];
    //
    //        endDot = [[UIView alloc] initWithFrame:CGRectMake(([mytouch locationInView:self].x - 5.0f), ([mytouch locationInView:self].y - 5.0f), 10.0f, 10.0f)];
    //        [endDot setBackgroundColor:[UIColor whiteColor]];
    //        [endDot.layer setCornerRadius:5.0f];
    //        [self addSubview:endDot];
    //    }
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
    UITouch *mytouch=[[touches allObjects] objectAtIndex:0];
    [myPath addLineToPoint:[mytouch locationInView:self]];
    [pathArray addObject:myPath];
    
    //    UIView *whiteLine = [[UIView alloc] initWithFrame:CGRectMake(myPath.bounds.origin.x, myPath.bounds.origin.y, myPath.bounds.size.width, myPath.bounds.size.height)];
    //    [self addSubview:whiteLine];
    
    // Remove the dots
    if (startDot) {
        [startDot removeFromSuperview];
        startDot = Nil;
    }
    
    if (endDot) {
        [endDot removeFromSuperview];
        endDot = Nil;
    }
    
    [self setNeedsDisplay];
}



@end
