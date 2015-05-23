//
//  UIImage+TGGlobalImage.m
//  Taligate
//
//  Created by Soumarsi Kundu on 29/04/15.
//  Copyright (c) 2015 esolz. All rights reserved.
//

#import "UIImage+TGGlobalImage.h"

@implementation UIImage (TGGlobalImage)

+(UIImage *)DoneImage
{
    return [UIImage imageNamed:@"done"];
}

+(UIImage *)CancelImage
{
    return [UIImage imageNamed:@"cancel"];
}
+(UIImage *)DropDwonImage
{
    return [UIImage imageNamed:@"dropdownimage"];
}
+(UIImage *) HeaderTopImage
{
    return [UIImage imageNamed:@"topbar"];
}
@end
