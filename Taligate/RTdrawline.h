//
//  RTdrawline.h
//  Restaurant
//
//  Created by Anirban Tah on 26/08/14.
//  Copyright (c) 2014 Esolz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RTdrawline : UIView <UIGestureRecognizerDelegate>{
    UIColor *setStroke;
    UIBezierPath *myPath;
    NSMutableArray *pathArray;
    
    UIView *startDot;
    UIView *endDot;
}


@end
