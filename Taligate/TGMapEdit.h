//
//  TGMapEdit.h
//  Taligate
//
//  Created by Soumarsi Kundu on 27/03/15.
//  Copyright (c) 2015 esolz. All rights reserved.
//



#import <UIKit/UIKit.h>
#import "TGGlobal.h"
#import "Taligate-Prefix.pch"

@interface TGMapEdit : UIView<UITextViewDelegate>
{
        __weak id <TGGlobal> _delegate;
    
    UIView *BackPopupView,*BackSubPopView;
    UILabel *_ButtonLabel;
    UITextView *_DescriptionText;
    UIButton *DropDownButton;
    UIButton *SubmitButton,*CancelButton;
    UIImageView *Dropdown;
    UIImageView *_backview;
}
@property (nonatomic, weak) id <TGGlobal> delegate;
@property(nonatomic)UILabel *ButtonLabel;
@property(nonatomic)UITextView *DescriptionText;
@property(nonatomic)UIImageView *backview;
@end
