//
//  TGMapEdit.m
//  Taligate
//
//  Created by Soumarsi Kundu on 27/03/15.
//  Copyright (c) 2015 esolz. All rights reserved.
//

#import "TGMapEdit.h"
@implementation TGMapEdit
@synthesize delegate = _delegate;
@synthesize ButtonLabel =_ButtonLabel;
@synthesize DescriptionText =_DescriptionText;
@synthesize backview = _backview;
@synthesize submitButton = SubmitButton;
@synthesize BackPopupView = _BackPopupView;
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        
        BackPopupView  = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, 387.5, 237.5)];
        [BackPopupView setBackgroundColor:[UIColor ClearColor]];
        [self addSubview:BackPopupView];
        
        _backview = [[UIImageView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, 387.5f, 237.5f)];
        //[_backview setImage:[UIImage imageNamed:@"mappopup"]];
        [BackPopupView addSubview:_backview];
        
        DropDownButton = [[UIButton alloc]initWithFrame:CGRectMake(25.0f, 23.0f, 350.0f, 40.0f)];
        [DropDownButton setBackgroundColor:[UIColor ClearColor]];
        [DropDownButton addTarget:_delegate action:@selector(DropDown:) forControlEvents:UIControlEventTouchUpInside];
        [BackPopupView addSubview:DropDownButton];
        
        _ButtonLabel = [[UILabel alloc]initWithFrame:CGRectMake(10.0f, 5.0f, 320.0f, 40.0f)];
        [_ButtonLabel setBackgroundColor:[UIColor ClearColor]];
        [_ButtonLabel setText:@"Select the order from list"];
        [_ButtonLabel setTextAlignment:NSTextAlignmentLeft];
        _ButtonLabel.textColor = [UIColor MapButtonColor];
        _ButtonLabel.font = [UIFont MapEditButtonLabel];
        [DropDownButton addSubview:_ButtonLabel];
        
        
        Dropdown = [[UIImageView alloc]initWithFrame:CGRectMake(300, 13.5f, 22, 22)];
        [Dropdown setImage:[UIImage DropDwonImage]];
        [DropDownButton addSubview:Dropdown];
//        BackSubPopView = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 70.0f, 500.0f, 300-70)];
//        [BackSubPopView setBackgroundColor:[UIColor clearColor]];
//        [BackPopupView addSubview:BackSubPopView];
        
//        --------Checkbox--------
        
//        _checkbox = [[UIButton alloc]initWithFrame:CGRectMake(25.0f, _ButtonLabel.frame.origin.y+10.0f, 10.0f, 10.0f)];
//        [_checkbox setImage:[UIImage imageNamed:@"uncheck"] forState:UIControlStateNormal];
//        [_checkbox addTarget:_delegate action:@selector(checkbox:) forControlEvents:UIControlEventTouchUpInside];
//        [BackPopupView addSubview:_checkbox];
        
////        ---------TableView-----------
//        
//        _locationDataTableview = [[UITableView alloc]initWithFrame:CGRectMake(25,74,340,95)];
//        _locationDataTableview.backgroundColor = [UIColor ClearColor];
//        _locationDataTableview.delegate = self;
//        [BackPopupView addSubview:_locationDataTableview];

        
        _DescriptionText = [[UITextView alloc]initWithFrame:CGRectMake(25,74,340,95)];
        _DescriptionText.font = [UIFont MapEditDescriptionLabel];
        _DescriptionText.backgroundColor = [UIColor ClearColor];
        _DescriptionText.textColor = [UIColor MapButtonColor];
        _DescriptionText.scrollEnabled = YES;
        _DescriptionText.pagingEnabled = YES;
        _DescriptionText.editable = NO;
        _DescriptionText.delegate = self;
        _DescriptionText.textAlignment = NSTextAlignmentLeft;
        [_DescriptionText setAutocorrectionType:UITextAutocorrectionTypeNo];
        [BackPopupView addSubview:_DescriptionText];
        
        
        CancelButton = [[UIButton alloc]initWithFrame:CGRectMake(270, 175, 83.0f, 35)];
        [CancelButton setBackgroundColor:[UIColor ClearColor]];
        [CancelButton setBackgroundImage:[UIImage CancelImage] forState:UIControlStateNormal];
        [CancelButton addTarget:_delegate action:@selector(CanCel:) forControlEvents:UIControlEventTouchUpInside];
        [BackPopupView addSubview:CancelButton];
      
        
        SubmitButton = [[UIButton alloc]initWithFrame:CGRectMake(180, 175, 83.0f, 35)];
        [SubmitButton setBackgroundColor:[UIColor ClearColor]];
        [SubmitButton setBackgroundImage:[UIImage DoneImage] forState:UIControlStateNormal];
        SubmitButton.alpha = 0.25f;
        [SubmitButton addTarget:_delegate action:@selector(Submit:) forControlEvents:UIControlEventTouchUpInside];
        [BackPopupView addSubview:SubmitButton];
        
        
           }
    return self;
}

@end
