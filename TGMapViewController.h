//
//  TGMapViewController.h
//  Taligate
//
//  Created by Soumarsi Kundu on 27/03/15.
//  Copyright (c) 2015 esolz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TGMapEdit.h"

@interface TGMapViewController : UIViewController<UIGestureRecognizerDelegate,TGGlobal,UIPickerViewDataSource,UIPickerViewDelegate>
{
    UIView *BackGroundView,*HeaderView,*HeaderLineView;
    UILabel *HeaderLabel;
    UIImageView *SettingsImage,*MapImage,*MapView;
    UIView *PickerBckView;
    UIPickerView *DataPickerView;
    NSString *DataString;
    UIButton *DoneButton,*CancelButton;
    UIView *BeconsImage;
    NSMutableArray *SavedDataArray;
    NSString *searchtext;
    NSMutableArray *searchresult;
    UITableView *searchtableview;
    NSMutableArray *sampleMarkerLocations;
    int zoommap;
    UIButton *BackButton;
    UIView *DisableView;
    UITableViewCell *cell ;
    NSMutableArray *array;
    NSMutableDictionary *SavedDict;
}
@property (nonatomic,strong)NSString *VenueName;
@property (nonatomic) float LocationLattitude;
@property (nonatomic) float LocationLongitude;
@end
