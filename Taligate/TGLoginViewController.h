//
//  TGLoginViewController.h
//  Taligate
//
//  Created by Soumarsi Kundu on 13/04/15.
//  Copyright (c) 2015 esolz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TGGlobal.h"

@interface TGLoginViewController : UIViewController<TGGlobal,UIAlertViewDelegate>
{
    
    UIAlertView *Alert;
}
@property (weak, nonatomic) IBOutlet UILabel *SignInLabel;
@property (weak, nonatomic) IBOutlet UIButton *SignInButton;
@property (weak, nonatomic) IBOutlet UITextField *Username;
@property (weak, nonatomic) IBOutlet UITextField *Password;
@property (weak, nonatomic) IBOutlet UIView *MainView;



@end
