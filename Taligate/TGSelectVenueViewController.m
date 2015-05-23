//
//  TGSelectVenueViewController.m
//  Taligate
//
//  Created by Soumarsi Kundu on 13/04/15.
//  Copyright (c) 2015 esolz. All rights reserved.
//

#import "TGSelectVenueViewController.h"
#import "TGMapViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "TGGlobalClass.h"
#import "TGGlobal.h"
#import "Taligate-Prefix.pch"
@interface TGSelectVenueViewController ()
{
    TGGlobalClass *GlobalClass;
}


@end
#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
@implementation TGSelectVenueViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    GlobalClass = [[TGGlobalClass alloc]init];
    
    
    _VenueArray = [[NSMutableArray alloc]init];
    LocationData = [[NSMutableArray alloc]init];
    
    locationManager = [[CLLocationManager alloc] init];
    if(IS_OS_8_OR_LATER) {
        
        NSUInteger code = [CLLocationManager authorizationStatus];
        
        if (code == kCLAuthorizationStatusNotDetermined && ([locationManager respondsToSelector:@selector(requestAlwaysAuthorization)] || [locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)])) {
            
            // choose one request according to your business.
            if([[NSBundle mainBundle] objectForInfoDictionaryKey:@"NSLocationAlwaysUsageDescription"]){
                [locationManager  requestAlwaysAuthorization];
            } else if([[NSBundle mainBundle] objectForInfoDictionaryKey:@"NSLocationWhenInUseUsageDescription"]) {
                [locationManager  requestWhenInUseAuthorization];
            } else {
        }
    }
}
    
    locationManager.delegate=self;
    locationManager.desiredAccuracy=kCLLocationAccuracyBest;
    locationManager.distanceFilter=kCLDistanceFilterNone;
    [locationManager startUpdatingLocation];

    [GlobalClass GlobalDict:[NSString stringWithFormat:@"%@action.php?mode=locationInfo",App_Domain_Url] Withblock:^(id result, NSError *error) {
       
        if ([[result objectForKey:@"message"] isEqualToString:success])
        {
            DebugLog(@"--------//---- :%@", [result objectForKey:@"locationdata"]);
            
            LocationData = [result objectForKey:@"locationdata"];
            for (data = 0; data < LocationData.count; data ++)
            {
                Locationdict = [[NSMutableDictionary alloc]init];
                
                [Locationdict setObject:[[LocationData objectAtIndex:data]objectForKey:@"name"] forKey:@"name"];
                [Locationdict setObject:[[LocationData objectAtIndex:data]objectForKey:@"latitude"] forKey:@"latitude"];
                [Locationdict setObject:[[LocationData objectAtIndex:data]objectForKey:@"longitude"] forKey:@"longitude"];
                [_VenueArray addObject:Locationdict];
            }
            _VenuePicker.delegate = self;
            _VenuePicker.dataSource = self;
            _VenuePicker.transform = CGAffineTransformMakeScale(2, 2);

            [_VenuePicker selectRow:0 inComponent:0 animated:NO];
            VenueString = [[_VenueArray objectAtIndex:[_VenuePicker selectedRowInComponent:0]] objectForKey:@"name"];
            latitude = [[[_VenueArray objectAtIndex:[_VenuePicker selectedRowInComponent:0]] objectForKey:@"latitude"] floatValue];
            longitude = [[[_VenueArray objectAtIndex:[_VenuePicker selectedRowInComponent:0]] objectForKey:@"longitude"] floatValue];
        }
        
    }];
    
    
    
    // Do any additional setup after loading the view.
}
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *retval = (id)view;
    if (!retval) {
        retval= [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [pickerView rowSizeForComponent:component].width, [pickerView rowSizeForComponent:component].height)] ;
    }
    
    retval.textAlignment= NSTextAlignmentCenter;
    retval.textColor = [UIColor blackColor];
    retval.font = [UIFont PickerLabel];
    retval.text = [[_VenueArray objectAtIndex:row] objectForKey:@"name"];
    return retval;
}
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 30.0f;
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return _VenueArray.count;
}
- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return _VenueArray[row];
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    VenueString = [[_VenueArray objectAtIndex:[pickerView selectedRowInComponent:0]] objectForKey:@"name"];
    latitude = [[[_VenueArray objectAtIndex:[_VenuePicker selectedRowInComponent:0]] objectForKey:@"latitude"] floatValue];
    longitude = [[[_VenueArray objectAtIndex:[_VenuePicker selectedRowInComponent:0]] objectForKey:@"longitude"] floatValue];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    
}
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    
    CLLocation *currentLocation = newLocation;
    
    
    [locationManager stopUpdatingLocation];
    if (currentLocation != nil) {
        
        
        
//        latitude=  currentLocation.coordinate.latitude;
//        longitude=  currentLocation.coordinate.longitude;
    }
    
    // this creates a MKReverseGeocoder to find a placemark using the found coordinates
    
    
    //stops didUpdateToLocation to be called infinite times
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(IBAction)Settings:(UIButton *)sender
{
    
    SettingsPopUp = [[UIActionSheet alloc] initWithTitle:nil
                                            delegate:self
                                            cancelButtonTitle:@"Cancel"
                                            destructiveButtonTitle:@"Logout"
                                            otherButtonTitles:nil];
      [SettingsPopUp showInView:self.view];
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"The %ld button was tapped.",(long)buttonIndex);
    
    if (buttonIndex == 0)
    {
        [[NSUserDefaults standardUserDefaults]setObject:@"NO" forKey:@"Logout"];
        
        [actionSheet dismissWithClickedButtonIndex:0 animated:YES];
        
        TGSelectVenueViewController *Logout = [self.storyboard instantiateViewControllerWithIdentifier:@"login"];
        [self.navigationController pushViewController:Logout animated:YES];
    }
}

- (IBAction)venueselect:(UIButton *)sender {
    TGMapViewController *map = [[TGMapViewController alloc]init];
    [map setVenueName:VenueString];
    [map setLocationLattitude:latitude];
    [map setLocationLongitude:longitude];
    [self.navigationController pushViewController:map animated:YES];
}
@end
