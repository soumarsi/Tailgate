//
//  RTCanvas.h
//  Restaurant
//
//  Created by Soumalya Banerjee on 6/13/14.
//  Copyright (c) 2014 Esolz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RTdrawline.h"
@interface RTCanvas : UIView <UIGestureRecognizerDelegate>{
    UIColor *setStroke;
    UIBezierPath *myPath;
    NSMutableArray *pathArray;
    RTdrawline *linedraw;
    UIView *startDot;
    UIView *endDot;
}
@property(nonatomic, assign) CGPoint centerPoint;
@property(nonatomic, assign) CGPoint startPoint;
@property(nonatomic, assign) CGPoint endPoint;

@property(nonatomic, strong) NSMutableArray* lines;

@end
