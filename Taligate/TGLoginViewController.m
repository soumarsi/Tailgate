//
//  TGLoginViewController.m
//  Taligate
//
//  Created by Soumarsi Kundu on 13/04/15.
//  Copyright (c) 2015 esolz. All rights reserved.
//

#import "TGLoginViewController.h"
#import "TGGlobalClass.h"

@interface TGLoginViewController ()<UITextFieldDelegate>
{
    TGGlobalClass *GlobalClass;
}

@end

@implementation TGLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    GlobalClass = [[TGGlobalClass alloc]init];
    _Username.text = @"Admin";
    _Password.text = @"admin";
    // Do any additional setup after loading the view.
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField.tag == 1)
    {
        
        [UIView animateWithDuration:0.3 animations:^{
             _MainView.frame = CGRectMake(0.0f, -100.0f, self.view.frame.size.width, self.view.frame.size.height);
        } completion:^(BOOL finished) {
            
        }];
       
        
    }
    else if (textField.tag == 2)
    {
        [UIView animateWithDuration:0.3 animations:^{
            _MainView.frame = CGRectMake(0.0f, -100.0f, self.view.frame.size.width, self.view.frame.size.height);
        } completion:^(BOOL finished) {
            
        }];
    }
}


- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    if (textField.tag == 1)
    {
        [UIView animateWithDuration:0.3 animations:^{
            _MainView.frame = CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height);
        } completion:^(BOOL finished) {
            
        }];
    }
    else if (textField.tag == 2)
    {
        [UIView animateWithDuration:0.3 animations:^{
            _MainView.frame = CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height);
        } completion:^(BOOL finished) {
            
        }];
    }
}
- (void)Signin:(UIButton *)sender
{
    [_Username resignFirstResponder];
    [_Password resignFirstResponder];
    
    if (_Username.tag == 1)
    {
        [UIView animateWithDuration:0.3 animations:^{
            _MainView.frame = CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height);
        } completion:^(BOOL finished) {
            
        }];
    }
    else if (_Password.tag == 2)
    {
        [UIView animateWithDuration:0.3 animations:^{
            _MainView.frame = CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height);
        } completion:^(BOOL finished) {
            
        }];
    }
    
    if (GlobalClass.connectedToNetwork == YES)
    {
     if ([_Username.text isEqualToString:@""])
    {
        _Username.placeholder = check_username;
        [_Username setValue:[UIColor redColor]forKeyPath:@"_placeholderLabel.textColor"];
        [_Username setValue:[UIFont LoginLabel] forKeyPath:@"_placeholderLabel.font"];
    }
    else if ([_Password.text isEqualToString:@""])
    {
        _Password.placeholder = check_password;
        [_Password setValue:[UIColor redColor]forKeyPath:@"_placeholderLabel.textColor"];
        [_Password setValue:[UIFont LoginLabel] forKeyPath:@"_placeholderLabel.font"];
    }
    else if ([_Username.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet] ].length <1)
    {
        _Username.placeholder = check_username;
        [_Username setValue:[UIColor redColor]forKeyPath:@"_placeholderLabel.textColor"];
        [_Username setValue:[UIFont LoginLabel] forKeyPath:@"_placeholderLabel.font"];
    }
    else
    {
        
    [GlobalClass GlobalDict:[NSString stringWithFormat:@"%@action.php?mode=adminLogin&email=%@&password=%@",App_Domain_Url,[_Username.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],_Password.text] Withblock:^(id result, NSError *error) {
       
    if (result)
    {
        DebugLog(@"result-- %@",result);
            
        if ([[result objectForKey:@"message"] isEqualToString:success])
        {
            
            [GlobalClass Userdict:[result objectForKey:@"userdata"]];
            
            
            
            TGLoginViewController *login = [self.storyboard instantiateViewControllerWithIdentifier:@"selectvenue"];
            [self.navigationController pushViewController:login animated:YES];

        }
        else if ([[result objectForKey:@"message"] isEqualToString:Login_Failed])
        {
            Alert = [[UIAlertView alloc]initWithTitle:check_internet_title message:Login_Failed delegate:self cancelButtonTitle:Ok otherButtonTitles: nil];
            [Alert show];
            
            _Username.text = @"";
            _Password.text = @"";
        }
    }
        else if (error)
        {
            NSLog(@"error  %@", error);
        }
        
    }];

    }
}
    else
    {
        Alert = [[UIAlertView alloc]initWithTitle:check_internet_title message:check_internet delegate:self cancelButtonTitle:Ok otherButtonTitles:nil];
        [Alert show];
    }
}

- (void)Forgotpassword:(UIButton *)sender {
    
    TGLoginViewController *forgot = [self.storyboard instantiateViewControllerWithIdentifier:@"forgot"];
    [self.navigationController pushViewController:forgot animated:YES];
    
}
@end
