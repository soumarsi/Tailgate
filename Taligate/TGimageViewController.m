//
//  TGimageViewController.m
//  Taligate
//
//  Created by Soumarsi Kundu on 31/03/15.
//  Copyright (c) 2015 esolz. All rights reserved.
//

#import "TGimageViewController.h"

@interface TGimageViewController ()

@end

@implementation TGimageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"image----:%@",_Imageset);
    
    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(0.0f, 70.0f, self.view.frame.size.width, self.view.frame.size.height-70)];
    [image setImage:_Imageset];
    [self.view addSubview:image];
    
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

@end
