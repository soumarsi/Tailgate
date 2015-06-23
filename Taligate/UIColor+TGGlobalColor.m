//
//  UIColor+TGGlobalColor.m
//  Taligate
//
//  Created by Soumarsi Kundu on 29/04/15.
//  Copyright (c) 2015 esolz. All rights reserved.
//

#import "UIColor+TGGlobalColor.h"

@implementation UIColor (TGGlobalColor)

+(UIColor *)MapButtonColor
{
    return [UIColor colorWithRed:(117.0f/255.0f) green:(117.0f / 255.0f) blue:(117.0f / 255.0f) alpha:1.0f];
}
+(UIColor *) ClearColor
{
    return [UIColor clearColor];
}
+(UIColor *) LabelWhiteColor
{
    return [UIColor whiteColor];
}
+(UIColor *) AlphaBackground
{
    return [UIColor colorWithRed:(0.0f / 255.0f) green:(0.0f / 255.0f) blue:(0.0f / 255.0f) alpha:0.6f];
}
+(UIColor *) BlackColor
{
    return [UIColor blackColor];
}
+(UIColor *) MapSaveBackgroundColor
{
    return [UIColor colorWithRed:(232.0f / 255.0f) green:(228.0f / 255.0f) blue:(220.0f / 255.0f) alpha:1.0f];
}
@end
