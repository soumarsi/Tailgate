//
//  TGSelectVenueViewController.h
//  Taligate
//
//  Created by Soumarsi Kundu on 13/04/15.
//  Copyright (c) 2015 esolz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TGGlobal.h"
#import <CoreLocation/CoreLocation.h>
@interface TGSelectVenueViewController : UIViewController<UIPickerViewDataSource,UIPickerViewDelegate,CLLocationManagerDelegate,TGGlobal,UIActionSheetDelegate>
{
    NSString *VenueString;
    CLLocationManager *locationManager;
    float latitude;
    float longitude;
    NSMutableArray *LocationData;
    NSMutableDictionary *Locationdict;
    int data;
    UIActionSheet *SettingsPopUp;
}
@property (strong, nonatomic) IBOutlet UIView *MainView;
@property (retain, nonatomic) IBOutlet UIPickerView *VenuePicker;
@property(nonatomic,retain) NSMutableArray *VenueArray;
- (IBAction)venueselect:(UIButton *)sender;

@end
