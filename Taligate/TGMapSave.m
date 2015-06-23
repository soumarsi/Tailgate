//
//  TGMapSave.m
//  Taligate
//
//  Created by Soumarsi Kundu on 13/06/15.
//  Copyright (c) 2015 esolz. All rights reserved.
//

#import "TGMapSave.h"

@implementation TGMapSave

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
        
        BackgroundView = [[UIView alloc]initWithFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.frame.size.height)];
        [BackgroundView setBackgroundColor:[UIColor AlphaBackground]];
        [self addSubview:BackgroundView];
        
        ContentBackView  = [[UIView alloc]initWithFrame:CGRectMake(self.frame.origin.x+200, self.frame.origin.y+150, self.frame.size.width-400, self.frame.size.height-300)];
        [ContentBackView setBackgroundColor:[UIColor LabelWhiteColor]];
        ContentBackView.layer.cornerRadius = 5.0f;
        [self addSubview:ContentBackView];
        
     //// ************* Label ************* /////////
        FirstLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.frame.origin.x+240, self.frame.origin.y+200, 250, 50)];
        [FirstLabel setBackgroundColor:[UIColor ClearColor]];
        [FirstLabel setFont:[UIFont MapEditButtonLabel]];
        [FirstLabel setText:@"You are setup across from"];
        [FirstLabel setTextAlignment:NSTextAlignmentLeft];
        [FirstLabel setTextColor:[UIColor BlackColor]];
        [self addSubview:FirstLabel];
        
        SecondLabel = [[UILabel alloc]initWithFrame:CGRectMake(ContentBackView.frame.origin.x+40, FirstLabel.frame.origin.y+50, 100, 50)];
        [SecondLabel setBackgroundColor:[UIColor ClearColor]];
        [SecondLabel setFont:[UIFont MapEditButtonLabel]];
        [SecondLabel setText:@"in the"];
        [SecondLabel setTextAlignment:NSTextAlignmentLeft];
        [SecondLabel setTextColor:[UIColor BlackColor]];
        [self addSubview:SecondLabel];
        
        ThirdLabel = [[UILabel alloc]initWithFrame:CGRectMake(ContentBackView.frame.origin.x+300-60, SecondLabel.frame.origin.y+50, 100, 50)];
        [ThirdLabel setBackgroundColor:[UIColor ClearColor]];
        [ThirdLabel setFont:[UIFont MapEditButtonLabel]];
        [ThirdLabel setText:@"yards off of"];
        [ThirdLabel setTextAlignment:NSTextAlignmentLeft];
        [ThirdLabel setTextColor:[UIColor BlackColor]];
        [self addSubview:ThirdLabel];
        
        FourthLabel = [[UILabel alloc]initWithFrame:CGRectMake(ContentBackView.frame.origin.x+40, ThirdLabel.frame.origin.y+50, 250, 50)];
        [FourthLabel setBackgroundColor:[UIColor ClearColor]];
        [FourthLabel setFont:[UIFont MapEditButtonLabel]];
        [FourthLabel setText:@"Your tent color is"];
        [FourthLabel setTextAlignment:NSTextAlignmentLeft];
        [FourthLabel setTextColor:[UIColor BlackColor]];
        [self addSubview:FourthLabel];
        
        FifthLabel = [[UILabel alloc]initWithFrame:CGRectMake(ContentBackView.frame.origin.x+40, FourthLabel.frame.origin.y+50, 570, 50)];
        [FifthLabel setBackgroundColor:[UIColor ClearColor]];
        [FifthLabel setFont:[UIFont MapEditButtonLabel]];
        [FifthLabel setText:@"with a name ID Tag hanging from your tent with your name on it."];
        [FifthLabel setTextAlignment:NSTextAlignmentLeft];
        [FifthLabel setTextColor:[UIColor BlackColor]];
        [self addSubview:FifthLabel];

        //  ************************* ///////////
        
        //// ********** Button
        
        self.PlacesLabel = [[UIButton alloc]initWithFrame:CGRectMake(self.frame.origin.x+240+FirstLabel.frame.size.width-30, self.frame.origin.y+210, 310, 30)];
        [self.PlacesLabel setImageEdgeInsets:UIEdgeInsetsMake(0, 285, 0, 0)];
        [self.PlacesLabel setTitleEdgeInsets:UIEdgeInsetsMake(1.0f, -15, 0, 0)];
        [self.PlacesLabel setBackgroundColor:[UIColor MapSaveBackgroundColor]];
        [self.PlacesLabel setTitle:@"Places" forState:UIControlStateNormal];
        self.PlacesLabel.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.PlacesLabel setTitleColor:[UIColor BlackColor] forState:UIControlStateNormal];
        self.PlacesLabel.titleLabel.font = [UIFont MapEditButtonLabel];
        [self.PlacesLabel setImage:[UIImage DropDwonImage] forState:UIControlStateNormal];
        [self.PlacesLabel setImage:[UIImage DropDwonImage] forState:UIControlStateHighlighted];
        [self.PlacesLabel addTarget:_Delegate action:@selector(PlaceButton:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.PlacesLabel];
        
        self.PackegeLabel = [[UIButton alloc]initWithFrame:CGRectMake(ContentBackView.frame.origin.x+40+SecondLabel.frame.size.width-30, FirstLabel.frame.origin.y+60, 220, 30)];
        [self.PackegeLabel setBackgroundColor:[UIColor MapSaveBackgroundColor]];
        [self.PackegeLabel setImageEdgeInsets:UIEdgeInsetsMake(0, 195, 0, 0)];
        [self.PackegeLabel setTitleEdgeInsets:UIEdgeInsetsMake(1.0f, -15, 0, 0)];
        [self.PackegeLabel setTitle:@"Package" forState:UIControlStateNormal];
        self.PackegeLabel.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.PackegeLabel setTitleColor:[UIColor BlackColor] forState:UIControlStateNormal];
        self.PackegeLabel.titleLabel.font = [UIFont MapEditButtonLabel];
        [self.PackegeLabel setImage:[UIImage DropDwonImage] forState:UIControlStateNormal];
        [self.PackegeLabel setImage:[UIImage DropDwonImage] forState:UIControlStateHighlighted];
        [self.PackegeLabel addTarget:_Delegate action:@selector(PackageButton:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.PackegeLabel];
        
        self.DistanceLabel = [[UIButton alloc]initWithFrame:CGRectMake(ContentBackView.frame.origin.x+40, SecondLabel.frame.origin.y+60, 180, 30)];
        [self.DistanceLabel setBackgroundColor:[UIColor MapSaveBackgroundColor]];
        [self.DistanceLabel setImageEdgeInsets:UIEdgeInsetsMake(0, 155, 0, 0)];
        [self.DistanceLabel setTitleEdgeInsets:UIEdgeInsetsMake(1.0f, -15, 0, 0)];
        [self.DistanceLabel setTitle:@"Distance" forState:UIControlStateNormal];
        self.DistanceLabel.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.DistanceLabel setTitleColor:[UIColor BlackColor] forState:UIControlStateNormal];
        self.DistanceLabel.titleLabel.font = [UIFont MapEditButtonLabel];
        [self.DistanceLabel setImage:[UIImage DropDwonImage] forState:UIControlStateNormal];
        [self.DistanceLabel setImage:[UIImage DropDwonImage] forState:UIControlStateHighlighted];
        [self.DistanceLabel addTarget:_Delegate action:@selector(DistanceButton:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.DistanceLabel];
        
        self.RoadLabel = [[UIButton alloc]initWithFrame:CGRectMake(ContentBackView.frame.origin.x+40+self.DistanceLabel.frame.size.width+ThirdLabel.frame.size.width+20, SecondLabel.frame.origin.y+60, 200, 30)];
        [self.RoadLabel setBackgroundColor:[UIColor MapSaveBackgroundColor]];
        [self.RoadLabel setImageEdgeInsets:UIEdgeInsetsMake(0, 175, 0, 0)];
        [self.RoadLabel setTitleEdgeInsets:UIEdgeInsetsMake(1.0f, -15, 0, 0)];
        [self.RoadLabel setTitle:@"Road" forState:UIControlStateNormal];
        self.RoadLabel.titleLabel.textAlignment = NSTextAlignmentLeft;
        [self.RoadLabel setTitleColor:[UIColor BlackColor] forState:UIControlStateNormal];
        self.RoadLabel.titleLabel.font = [UIFont MapEditButtonLabel];
        [self.RoadLabel setImage:[UIImage DropDwonImage] forState:UIControlStateNormal];
        [self.RoadLabel setImage:[UIImage DropDwonImage] forState:UIControlStateHighlighted];
        [self.RoadLabel addTarget:_Delegate action:@selector(RoadButton:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.RoadLabel];
        
        self.ColorLabel = [[UIButton alloc]initWithFrame:CGRectMake(ContentBackView.frame.origin.x+FourthLabel.frame.size.width-50, ThirdLabel.frame.origin.y+60, 220, 30)];
        [self.ColorLabel setBackgroundColor:[UIColor MapSaveBackgroundColor]];
        [self.ColorLabel setImageEdgeInsets:UIEdgeInsetsMake(0, 195, 0, 0)];
        [self.ColorLabel setTitleEdgeInsets:UIEdgeInsetsMake(1.0f, -15, 0, 0)];
        [self.ColorLabel setTitle:@"Color" forState:UIControlStateNormal];
        self.ColorLabel.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.ColorLabel setTitleColor:[UIColor BlackColor] forState:UIControlStateNormal];
        self.ColorLabel.titleLabel.font = [UIFont MapEditButtonLabel];
        [self.ColorLabel setImage:[UIImage DropDwonImage] forState:UIControlStateNormal];
        [self.ColorLabel setImage:[UIImage DropDwonImage] forState:UIControlStateHighlighted];
        [self.ColorLabel addTarget:_Delegate action:@selector(ColorButton:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.ColorLabel];
   
        
 //       **********/.//////////////////------------
        
        
        
        
        
        FinalSubmitButton = [[UIButton alloc]initWithFrame:CGRectMake(600.0f, FourthLabel.frame.origin.y+150, 83.0f, 35)];
        [FinalSubmitButton setBackgroundColor:[UIColor ClearColor]];
        [FinalSubmitButton setBackgroundImage:[UIImage DoneImage] forState:UIControlStateNormal];
        [FinalSubmitButton addTarget:_Delegate action:@selector(FinalSubmit:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:FinalSubmitButton];

        FinalCancelButton = [[UIButton alloc]initWithFrame:CGRectMake(700, FourthLabel.frame.origin.y+150, 83.0f, 35)];
        [FinalCancelButton setBackgroundColor:[UIColor ClearColor]];
        [FinalCancelButton setBackgroundImage:[UIImage CancelImage] forState:UIControlStateNormal];
        [FinalCancelButton addTarget:_Delegate action:@selector(FinalCanCel:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:FinalCancelButton];
        
    //    ************************* ////
        
        
        
        
        
    
    }
    return self;
}



@end
