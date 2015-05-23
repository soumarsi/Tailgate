//
//  TGBecons.h
//  Taligate
//
//  Created by Soumarsi Kundu on 30/03/15.
//  Copyright (c) 2015 esolz. All rights reserved.
//
@class TGBecons;
@protocol TGBecons <NSObject,UIGestureRecognizerDelegate>

@optional
- (void)dragAndDrop:(UIPanGestureRecognizer *)gestureRecognizer  targetView:(TGBecons *)targetView;

@end

#import <UIKit/UIKit.h>

@interface TGBecons : UIView<UIGestureRecognizerDelegate>
{
//    __weak id <TGBecons> _TgDelegate;
    
    UIView *RedBeconsView;
    BOOL _tLocked;
    BOOL _isTLocked;
    NSString *_ButtonLabel;
    NSString *_DescriptionText;
}

@property(assign)id<TGBecons> TgDelegate;
@property (nonatomic) BOOL tLocked;
@property (nonatomic) BOOL isTLocked;
@property (nonatomic) NSString *ButtonLabel;
@property (nonatomic) NSString *DescriptionText;
- (void)configure;
-(void)backcolor;
- (BOOL)isTLocked;
- (NSString *)ButtonLabel;
- (NSString *)DescriptionText;
@end
