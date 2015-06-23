//
//  TGGlobal.h
//  Taligate
//
//  Created by Soumarsi Kundu on 20/04/15.
//  Copyright (c) 2015 esolz. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TGGlobal <NSObject>

@optional
-(void)Submit:(UIButton *)sender;
-(void)CanCel:(UIButton *)sender;
-(void)DropDown:(UIButton *)sender;
-(void)checkbox:(UIButton *)sender;
-(void)Forgotpassword:(UIButton *)sender;
-(void)Signin:(UIButton *)sender;
-(void)Settings:(UIButton *)sender;
-(void)FinalSubmit:(UIButton *)sender;
-(void)FinalCanCel:(UIButton *)sender;
-(void)PlaceButton:(UIButton *)sender;
-(void)PackageButton:(UIButton *)sender;
-(void)DistanceButton:(UIButton *)sender;
-(void)RoadButton:(UIButton *)sender;
-(void)ColorButton:(UIButton *)sender;
typedef void(^Urlresponceblock)(id result, NSError *error);
@end