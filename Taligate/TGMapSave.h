//
//  TGMapSave.h
//  Taligate
//
//  Created by Soumarsi Kundu on 13/06/15.
//  Copyright (c) 2015 esolz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TGMapSave : UIView
{
    UIView *BackgroundView , *ContentBackView;
    UILabel *FirstLabel , *SecondLabel , *ThirdLabel , *FourthLabel , *FifthLabel;
    UIButton *FinalSubmitButton , *FinalCancelButton;
}

@property (nonatomic , weak) id<TGGlobal>Delegate;
@property (nonatomic) UIButton * PlacesLabel;
@property (nonatomic) UIButton * PackegeLabel;
@property (nonatomic) UIButton * DistanceLabel;
@property (nonatomic) UIButton * RoadLabel;
@property (nonatomic) UIButton * ColorLabel;
@end
