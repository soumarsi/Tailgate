//
//  UIFont+TGGlobalFont.m
//  Taligate
//
//  Created by Soumarsi Kundu on 29/04/15.
//  Copyright (c) 2015 esolz. All rights reserved.
//

#import "UIFont+TGGlobalFont.h"
#define RalewayBold @"Raleway-Bold_0.ttf"
#define RalewayExtraBold @"Raleway-ExtraBold_0.ttf"
#define RalewayExtraLight @"Raleway-ExtraLight_0.ttf"
#define RalewayHeavy @"Raleway-Heavy_0.ttf"
#define RalewayLight @"Raleway-Light_0.ttf"
#define RalewayMedium @"Raleway-Medium_0.ttf"
#define RalewayRegular @"Raleway-Regular_0.ttf"
#define RalewaySemiBold @"Raleway-SemiBold_0.ttf"
#define rock @"rock.ttf"
#define rockb @"rockb.ttf"
@implementation UIFont (TGGlobalFont)

+(UIFont *)MapEditButtonLabel
{
    return [UIFont fontWithName:RalewaySemiBold size:15.0f];
}
+(UIFont *)MapEditDescriptionLabel
{
    return [UIFont fontWithName:RalewayLight size:16];
}
+(UIFont *)MapViewHeaderLabel
{
    return [UIFont fontWithName:RalewayBold size:30];
}
+(UIFont *)ButtonLabel
{
    return [UIFont fontWithName:RalewayRegular size:15];
}
+(UIFont *)PickerLabel
{
    return [UIFont fontWithName:RalewayLight size:40];
}
+(UIFont *)LoginLabel
{
    return [UIFont fontWithName:RalewaySemiBold size:14];
}
@end
