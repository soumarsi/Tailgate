//
//  TGMapViewController.h
//  Taligate
//
//  Created by Soumarsi Kundu on 27/03/15.
//  Copyright (c) 2015 esolz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TGMapEdit.h"

@interface TGMapViewController : UIViewController<UIGestureRecognizerDelegate,TGGlobal,UIPickerViewDataSource,UIPickerViewDelegate,UITableViewDataSource,UITableViewDelegate>
{
    UIView *BackGroundView,*HeaderView,*HeaderLineView;
    UILabel *HeaderLabel;
    UIImageView *SettingsImage,*MapImage,*MapView;
    UIView *PickerBckView,*AfterSavePickerView;
    UIPickerView *DataPickerView,*PopupPicker;
    NSString *DataString;
    NSString *orderID;
    NSString *descString;
    UIButton *DoneButton,*CancelButton,*PopupDoneButton,*PopupCancelButton;
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
    NSMutableDictionary *preSavedDict;
    NSMutableDictionary *locationDataDict;
    NSMutableArray *locationDataArray;
    NSMutableArray *orderArray;
    NSMutableDictionary *orderDict;
    UITableView *locationTableview;
    int data;
    int Typecheck;
    NSString *CheckString;
    NSString *savepickerName;
    
    NSInteger check_box_number;
}
@property (nonatomic,strong)NSString *VenueName;
@property (nonatomic, strong)NSString *locationId;
@property (nonatomic) float LocationLattitude;
@property (nonatomic) float LocationLongitude;
@property (nonatomic, strong)NSString *Type;
@property (nonatomic, strong) NSMutableArray *PlaceaArray;
@property (nonatomic, strong) NSMutableArray *PackageArray;
@property (nonatomic, strong) NSMutableArray *DistanceArray;
@property (nonatomic, strong) NSMutableArray *RoadArray;
@property (nonatomic, strong) NSMutableArray *ColorArray;
@property (nonatomic, strong) NSMutableArray *GlobalPickerArray;
@property (nonatomic, strong) NSString *packegeIdString;
@property (nonatomic, strong) NSString *packegeNameString;
@property (nonatomic, strong) NSString *savePlaceId;
@property (nonatomic, strong) NSString *savePackegeId;
@property (nonatomic, strong) NSString *saveDistanceId;
@property (nonatomic, strong) NSString *saveRoadId;
@property (nonatomic, strong) NSString *saveColorId;
@end
