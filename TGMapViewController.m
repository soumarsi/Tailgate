//
//  TGMapViewController.m
//  Taligate
//
//  Created by Soumarsi Kundu on 27/03/15.
//  Copyright (c) 2015 esolz. All rights reserved.
//

#import "TGMapViewController.h"
#import "TGMapEdit.h"
#import "TGBecons.h"
#import "RTCanvas.h"
#import "TGimageViewController.h"
#import <MapKit/MapKit.h>
#import <GoogleMaps/GoogleMaps.h>
#import "GMDraggableMarkerManager.h"
#import "Taligate-Prefix.pch"
@interface TGMapViewController ()<TGBecons,MKMapViewDelegate,CLLocationManagerDelegate,UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate,GMDraggableMarkerManagerDelegate,GMSMapViewDelegate,UITextViewDelegate>
{
    TGMapEdit *EditView;
    NSMutableArray *DataArray;
    TGBecons *BeconsView;
    TGBecons *SelectedBecons;
    UIView *EditorVIEW;
    RTCanvas *editorArea;
    UIImage *img;
    MKMapView *Map;
    CLLocationManager *locationManager;
    CGPoint touchCoordinate;
    UITextField *SearchTextfield;
    GMSMapView *mapView_;
    NSOperationQueue *downloadQueue;
    GMDraggableMarkerManager *draggableMarkerManager;
}

@end

@implementation TGMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    DebugLog(@"self---- %f------ %f",self.view.frame.size.width,self.view.frame.size.height);
    
    downloadQueue = [[NSOperationQueue alloc]init];
    searchresult = [[NSMutableArray alloc]init];
    
    DataArray = [[NSMutableArray alloc]init];
    SavedDataArray = [[NSMutableArray alloc]init];
    
    
    //Backgroundview allocation//====
    
    BackGroundView = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height)];
    [BackGroundView setBackgroundColor:[UIColor LabelWhiteColor]];
    [self.view addSubview:BackGroundView];
    
    //Headerview====
    
    HeaderView = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, self.view.frame.size.width, 70)];
    [HeaderView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage HeaderTopImage]]];
    [BackGroundView addSubview:HeaderView];
    
    
    UIButton *SearchButton = [[UIButton alloc]initWithFrame:CGRectMake(430.0f, 25, 100, 30)];
    [SearchButton setBackgroundColor:[UIColor blueColor]];
    [SearchButton setTitle:@"Search" forState:UIControlStateNormal];
    SearchButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [SearchButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
   // SearchButton.titleLabel.font = [UIFont fontWithName:GLOBALTEXTFONT size:18];
    [SearchButton addTarget:self action:@selector(Search:) forControlEvents:UIControlEventTouchUpInside];
   // [HeaderView addSubview:SearchButton];
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]initWithObjectsAndKeys:@"25.3700",@"lat",@"85.1300",@"long", nil];
    
    NSMutableDictionary *dict1 = [[NSMutableDictionary alloc]initWithObjectsAndKeys:@"23.3500",@"lat",@"85.3300",@"long", nil];
    
    [SavedDataArray addObject:dict];
    [SavedDataArray addObject:dict1];
    
    
    //------
    //searchtextfield-----
    
    SearchTextfield = [[UITextField alloc]initWithFrame:CGRectMake(40.0f, 25, 350, 30)];
    [SearchTextfield setBackgroundColor:[UIColor clearColor]];
    [SearchTextfield setTextAlignment:NSTextAlignmentLeft];
    [SearchTextfield setTextColor:[UIColor blackColor]];
    //[SearchTextfield setFont:[UIFont fontWithName:GLOBALTEXTFONT size:16]];
    [SearchTextfield setDelegate:self];
    SearchTextfield.autocorrectionType = NO;
    SearchTextfield.autocorrectionType = NO;
    SearchTextfield.layer.borderWidth = 1.0f;
    SearchTextfield.layer.borderColor = [[UIColor blackColor]CGColor];
    SearchTextfield.layer.cornerRadius = 5.0f;
    //[HeaderView addSubview:SearchTextfield];
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:_LocationLattitude
                                                            longitude:_LocationLongitude
                                                                 zoom:16];
    mapView_ = [GMSMapView mapWithFrame:CGRectMake(0, 70, self.view.frame.size.width, self.view.frame.size.height) camera:camera];
    mapView_.myLocationEnabled = NO;
    mapView_.delegate = self;
    [BackGroundView addSubview: mapView_];
    mapView_.userInteractionEnabled = YES;
    
    
    [self applymapview];
    
    ///Header line-=====
    
    HeaderLineView = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 70.0f, self.view.frame.size.width, 1.0f)];
    [HeaderLineView setBackgroundColor:[UIColor blackColor]];
  //  [BackGroundView addSubview:HeaderLineView];
    
    
    searchtableview = [[UITableView alloc]initWithFrame:CGRectMake(40, 70, 350, 150)];
    searchtableview.delegate=self;
    searchtableview.dataSource=self;
    searchtableview.layer.borderWidth = 1.0f;
    searchtableview.layer.borderColor = [[UIColor grayColor]CGColor];
    searchtableview.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
    searchtableview.backgroundColor=[UIColor clearColor];
    searchtableview.showsVerticalScrollIndicator = NO;
    [BackGroundView addSubview:searchtableview];
    [searchtableview setHidden:YES];
    
    //HeaderLabel--=======
    
    HeaderLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 30.0f,self.view.frame.size.width, 25)];
    [HeaderLabel setBackgroundColor:[UIColor clearColor]];
    [HeaderLabel setText:_VenueName];
    [HeaderLabel setTextAlignment:NSTextAlignmentCenter];
    [HeaderLabel setTextColor:[UIColor whiteColor]];
    [HeaderLabel setFont:[UIFont MapViewHeaderLabel]];
    [HeaderView addSubview:HeaderLabel];
    
    //BackButton=========
    
    BackButton = [[UIButton alloc]initWithFrame:CGRectMake(30, 28, 28, 28)];
    [BackButton setBackgroundImage:[UIImage imageNamed:@"BackButton"] forState:UIControlStateNormal];
    [BackButton addTarget:self action:@selector(BackButton:) forControlEvents:UIControlEventTouchUpInside];
    [HeaderView addSubview:BackButton];
    
    
    //Settings image--======
    
    SettingsImage = [[UIImageView alloc]initWithFrame:CGRectMake(953, 28, 28, 28)];
    [SettingsImage setImage:[UIImage imageNamed:@"settings"]];
    [HeaderView addSubview:SettingsImage];
    
    
    
    
    DataArray = [[NSMutableArray alloc]initWithObjects:@"Name1",@"Name2",@"Name3",@"Name4",@"Name5", nil];
    
    PickerBckView  = [[UIView alloc]initWithFrame:CGRectMake(0.0f,600.0f, self.view.frame.size.width, self.view.frame.size.height-500.0f)];
    [PickerBckView setBackgroundColor:[UIColor whiteColor]];
    [PickerBckView setAlpha:1.0f];
    [self.view addSubview:PickerBckView];
    [PickerBckView setHidden:YES];
    
    DataPickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0,600, self.view.frame.size.width, self.view.frame.size.height-530.0f)];
    DataPickerView.layer.zPosition=9;
    DataPickerView.backgroundColor=[UIColor clearColor];
    DataPickerView.dataSource = self;
    DataPickerView.delegate = self;
    DataPickerView.showsSelectionIndicator = YES;
    [self.view addSubview:DataPickerView];
    [DataPickerView setHidden:YES];
    
    DoneButton = [[UIButton alloc]initWithFrame:CGRectMake(900, 610, 83, 35)];
    [DoneButton setBackgroundColor:[UIColor clearColor]];
    [DoneButton setBackgroundImage:[UIImage imageNamed:@"done"] forState:UIControlStateNormal];
    [DoneButton addTarget:self action:@selector(Done:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:DoneButton];
    [DoneButton setHidden:YES];
    
    CancelButton = [[UIButton alloc]initWithFrame:CGRectMake(800, 610, 83, 35)];
    [CancelButton setBackgroundColor:[UIColor clearColor]];
    [CancelButton setBackgroundImage:[UIImage imageNamed:@"cancel"] forState:UIControlStateNormal];
    [CancelButton addTarget:self action:@selector(CancelButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:CancelButton];
    [CancelButton setHidden:YES];
    
    
    //becons image--=====
    
    BeconsView = [[TGBecons alloc]initWithFrame:CGRectMake(865, 23, 40, 40)];
    BeconsView.TgDelegate = self;
    [BeconsView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"Becons"]]];
    [BeconsView configure];
    [BackGroundView addSubview:BeconsView];
    
    DisableView = [[UIView alloc]initWithFrame:CGRectMake(865.0f, 20.0f, 180.0f, 50.0f)];
    [DisableView setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:DisableView];
    [DisableView setHidden:YES];
    
    
    // Do any additional setup after loading the view.
}

-(void)applymapview
{
    
    // Create a GMSCameraPosition that tells the map to display the
    // coordinate -33.86,151.20 at zoom level 6.
    
    [SelectedBecons removeFromSuperview];
    
    // Creates a marker in the center of the map.
    GMSMarker *marker = [[GMSMarker alloc] init];
    marker.position = CLLocationCoordinate2DMake(-33.86, 151.20);
    marker.map = mapView_;
    
    draggableMarkerManager = [[GMDraggableMarkerManager alloc] initWithMapView:mapView_ delegate:self];
    
    
    DebugLog(@"savetablearray--------- > : %@", SavedDataArray);
    
    for (int k = 0; k< SavedDataArray.count; k++)
    {
        sampleMarkerLocations = [[NSMutableArray alloc] initWithObjects:[[CLLocation alloc] initWithLatitude:[[NSString stringWithFormat:@"%@",[[SavedDataArray objectAtIndex:k]objectForKey:@"lat"]]floatValue ] longitude:[[NSString stringWithFormat:@"%@",[[SavedDataArray objectAtIndex:k]objectForKey:@"long"]]floatValue ]],nil];
        for (CLLocation *sampleMarkerLocation in sampleMarkerLocations)
        {
            GMSMarker *marker = [GMSMarker markerWithPosition:sampleMarkerLocation.coordinate];
            
            switch (k) {
                    
                default:
                    [draggableMarkerManager addDraggableMarker:marker];
                    break;
            }
            marker.map = mapView_;
            
        }
    }
    
}

-(void)Submit:(UIButton *)sender
{
    if ([EditView.ButtonLabel.text isEqualToString:@"Select the order from list"])
    {
        
    }
    else
    {
        [DisableView setHidden:YES];
        
        UIView *screenshotview = [[UIView alloc]initWithFrame:CGRectMake(1025, 72.0f, self.view.frame.size.width, self.view.frame.size.height-70)];
        [screenshotview setBackgroundColor:[UIColor clearColor]];
        [BackGroundView addSubview:screenshotview];
    
    
        NSString *staticMapUrl = [NSString stringWithFormat:@"http://maps.google.com/maps/api/staticmap?markers=color:red|%f,%f&zoom=%d&size=1024x698&sensor=true",[[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"arrive_lat"]]floatValue],[[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"arrive_long"]]floatValue],zoommap];
        NSURL *mapUrl = [NSURL URLWithString:[staticMapUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        UIImage *image = [UIImage imageWithData: [NSData dataWithContentsOfURL:mapUrl]];
    
        MapView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0.0f, self.view.frame.size.width, self.view.frame.size.height-70)];
        [MapView setImage:image];
        [screenshotview addSubview:MapView];
 
        
        UIImageView *backview = [[UIImageView alloc]initWithFrame:CGRectMake(315.0f, 102.0f, 387.5f, 237.5f)];
        [backview setImage:[UIImage imageNamed:@"mappopupdown"]];
        [screenshotview addSubview:backview];


        UILabel *ButtonLabel = [[UILabel alloc]initWithFrame:CGRectMake(25.0f,23.0f, 340.0f, 45.0f)];
        [ButtonLabel setBackgroundColor:[UIColor clearColor]];
        [ButtonLabel setText:[NSString stringWithFormat:@"%@",EditView.ButtonLabel.text]];
        [ButtonLabel setTextAlignment:NSTextAlignmentLeft];
        [ButtonLabel setTextColor:[UIColor whiteColor]];
        [ButtonLabel setFont:[UIFont ButtonLabel]];
        [backview addSubview:ButtonLabel];

        UITextView *_DescriptionText = [[UITextView alloc]initWithFrame:CGRectMake(25,75,340,120)];
       _DescriptionText.font = [UIFont ButtonLabel];
        _DescriptionText.backgroundColor = [UIColor clearColor];
        _DescriptionText.textColor = [UIColor whiteColor];
        _DescriptionText.scrollEnabled = YES;
        _DescriptionText.pagingEnabled = YES;
        _DescriptionText.editable = NO;
        _DescriptionText.delegate = self;
        _DescriptionText.text = [NSString stringWithFormat:@"%@",EditView.DescriptionText.text];
        _DescriptionText.layer.borderWidth = 1.5f;
        _DescriptionText.layer.borderColor = [[UIColor colorWithRed:(179.0f/255.0f) green:(179.0f/255.0f) blue:(179.0f/255.0f) alpha:1] CGColor];
        _DescriptionText.textAlignment = NSTextAlignmentLeft;
        _DescriptionText.layer.cornerRadius = 3.0f;
        [_DescriptionText setAutocorrectionType:UITextAutocorrectionTypeNo];
        [backview addSubview:_DescriptionText];
    
    
        [self imageWithView:screenshotview];
    
 
        [SelectedBecons setButtonLabel:[NSString stringWithFormat:@"%@",EditView.ButtonLabel.text]];
        [SelectedBecons setDescriptionText:[NSString stringWithFormat:@"%@",EditView.DescriptionText.text]];
        
        NSDictionary *dict = [[NSDictionary alloc]initWithObjectsAndKeys:[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"arrive_lat"]],@"lat",[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"arrive_long"]],@"long", nil];
        
        [SavedDataArray addObject:dict];
        
        [SelectedBecons removeFromSuperview];
        
        [self applymapview];
        
        [EditView setHidden:YES];
        
        [self saveMapBecons];
    }
}
-(void)CanCel:(UIButton *)sender
{
    [EditView setHidden:YES];
    [SelectedBecons setHidden:YES];
    [PickerBckView setHidden:YES];
    [DataPickerView setHidden:YES];
    [DoneButton setHidden:YES];
    [CancelButton setHidden:YES];
    [DisableView setHidden:YES];
}
-(void)DropDown:(UIButton *)sender
{
    [PickerBckView setHidden:NO];
    [DataPickerView setHidden:NO];
    [DoneButton setHidden:NO];
    [CancelButton setHidden:NO];
    [DataPickerView selectRow:0 inComponent:0 animated:NO];
    DataString = [DataArray objectAtIndex:[DataPickerView selectedRowInComponent:0]] ;
}

//uipickerview delegate method///----------

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *retval = (id)view;
    if (!retval) {
        retval= [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [pickerView rowSizeForComponent:component].width, [pickerView rowSizeForComponent:component].height)] ;
    }
    
    retval.font = [UIFont PickerLabel];
    retval.textAlignment= NSTextAlignmentCenter;
    retval.textColor = [UIColor blackColor];
    retval.text = [DataArray objectAtIndex:row];
    return retval;
}
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 50.0f;
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return DataArray.count;
}
- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return DataArray[row];
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    DataString = [DataArray objectAtIndex:[pickerView selectedRowInComponent:0]] ;
}
///---------///---------//------
-(void)Done:(UIButton *)sender
{
    [PickerBckView setHidden:YES];
    [DataPickerView setHidden:YES];
    [DoneButton setHidden:YES];
    [CancelButton setHidden:YES];
    EditView.ButtonLabel.text = [NSString stringWithFormat:@"%@",DataString];
}

-(void)CancelButton:(UIButton *)sender
{
    [PickerBckView setHidden:YES];
    [DataPickerView setHidden:YES];
    [DoneButton setHidden:YES];
    [CancelButton setHidden:YES];
}

- (void)dragAndDrop:(UIPanGestureRecognizer *)gestureRecognizer targetView:(TGBecons *)targetView
{
    UIView *piece = [gestureRecognizer view];
    
    SelectedBecons = targetView;
    
    
    [self adjustAnchorPointForGestureRecognizer:gestureRecognizer targetView:targetView];
    
    if ([gestureRecognizer state] == UIGestureRecognizerStateBegan || [gestureRecognizer state] == UIGestureRecognizerStateChanged)
    {
        
        CGPoint translation = [gestureRecognizer translationInView:[piece superview]];
        [piece setCenter:CGPointMake([piece center].x + translation.x, [piece center].y + translation.y)];
        [gestureRecognizer setTranslation:CGPointZero inView:[piece superview]];
        
        if (piece.frame.origin.y >4)
        {
            
            DebugLog(@"entry");
            
            BeconsView = [[TGBecons alloc]initWithFrame:CGRectMake(865, 23, 40, 40)];
            BeconsView.TgDelegate = self;
            [BeconsView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"Becons"]]];
            [BeconsView configure];
            [BackGroundView addSubview:BeconsView];
            [DisableView setHidden:NO];
        }
    }
    
    
}


- (void)adjustAnchorPointForGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer targetView:(TGBecons *)targetView
{
    UIView *piece = [gestureRecognizer view];
    
    if ([gestureRecognizer state] == UIGestureRecognizerStateEnded)
    {
        
        
        BeconsView.userInteractionEnabled = NO;
        if (piece.frame.origin.y >60)
        {
            
            
            EditView = [[TGMapEdit alloc]init];
            [BackGroundView addSubview:EditView];
            
            if ( piece.frame.origin.x< 650 && piece.frame.origin.y > 170 && piece.frame.origin.y< 515)
            {
                DebugLog(@"1st");
                
                EditView.frame = CGRectMake(piece.frame.origin.x +30, piece.frame.origin.y-140, 387.5f, 237.5f);
                EditView.backview.image = [UIImage imageNamed:@"mappopup"];
              
            }
            else if (piece.frame.origin.x > 650 && piece.frame.origin.x < 1024 && piece.frame.origin.y > 170 && piece.frame.origin.y< 515)
            {
                 DebugLog(@"2nd");
                
                EditView.frame = CGRectMake(piece.frame.origin.x-380, piece.frame.origin.y-140, 387.5f, 237.5f);
                EditView.backview.image = [UIImage imageNamed:@"mappopupright"];
       
            }
            else if (piece.frame.origin.x > 0 && piece.frame.origin.x< 650 && piece.frame.origin.y < 170 && piece.frame.origin.y > 0)
            {
                DebugLog(@"3rd");
                
                EditView.frame = CGRectMake(piece.frame.origin.x-140, piece.frame.origin.y+45, 387.5f, 237.5f);
                EditView.backview.image = [UIImage imageNamed:@"mappopupup"];
            }
            else if (piece.frame.origin.x > 650 && piece.frame.origin.x < 980 && piece.frame.origin.y < 170 && piece.frame.origin.y > 0)
            {
                DebugLog(@"4th");
                
                EditView.frame = CGRectMake(piece.frame.origin.x-300, piece.frame.origin.y+45, 387.5f, 237.5f);
                EditView.backview.image = [UIImage imageNamed:@"mappopupup"];
            }
            else if (piece.frame.origin.x > 0 && piece.frame.origin.x< 650 && piece.frame.origin.y > 515 && piece.frame.origin.y < 729)
            {
                DebugLog(@"5th");
                
                EditView.frame=CGRectMake(piece.frame.origin.x-30, piece.frame.origin.y-250, 387.5f, 237.5f);
                EditView.backview.image = [UIImage imageNamed:@"mappopupdown"];
            }
            else if (piece.frame.origin.x > 650 && piece.frame.origin.x < 980 && piece.frame.origin.y > 515 && piece.frame.origin.y < 729)
            {
                DebugLog(@"7th");
                
                EditView.frame = CGRectMake(piece.frame.origin.x-330, piece.frame.origin.y-250, 387.5f, 237.5f);
                EditView.backview.image = [UIImage imageNamed:@"mappopupdown"];
            }

            DebugLog(@"piece------ %f--------%f",piece.frame.origin.x,piece.frame.origin.y);
            
            CLGeocoder *geocoder1 = [[CLGeocoder alloc] init];
            locationManager=[[CLLocationManager alloc]init];
            locationManager.delegate = self;
            [locationManager startUpdatingLocation];
            

            CGPoint touchPoint = CGPointMake(SelectedBecons.frame.origin.x+23, SelectedBecons.frame.origin.y-30);
            
            
            touchCoordinate = [mapView_ convertPoint:touchPoint toView:mapView_];
            
            CLLocationCoordinate2D coordinate = [mapView_.projection coordinateForPoint: touchCoordinate];
            
            float lat = coordinate.latitude;
            float lng = coordinate.longitude;
            
            DebugLog(@"lat long----- %f----- %f",lat,lng);
            
            [[NSUserDefaults standardUserDefaults]setFloat:lat forKey:@"arrive_lat"];
            
            [[NSUserDefaults standardUserDefaults]setFloat:lng forKey:@"arrive_long"];
            
            // map_View.showsUserLocation=YES;
            
            CLLocation *LocationAtual = [[CLLocation alloc] initWithLatitude:lat longitude:lng];
            
            [geocoder1 reverseGeocodeLocation:LocationAtual completionHandler:
             ^(NSArray *placemarks, NSError *error) {
                 
                 //Get address
                 CLPlacemark *placemark1 = [placemarks objectAtIndex:0];
                 
                 
                 //String to address
                 NSString *locatedaddress = [[placemark1.addressDictionary valueForKey:@"FormattedAddressLines"] componentsJoinedByString:@", "];
                 
                 DebugLog(@"locateaddress------ %@",locatedaddress);
                 
             }];
            
             [DisableView setHidden:NO];
            
        }
        else if (piece.frame.origin.y<59)
        {
            [BeconsView removeFromSuperview];
            
            [targetView removeFromSuperview];
            
            BeconsView = [[TGBecons alloc]initWithFrame:CGRectMake(865, 23, 40, 40)];
            BeconsView.TgDelegate = self;
            [BeconsView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"Becons"]]];
            [BeconsView configure];
            [BackGroundView addSubview:BeconsView];
        }
        
    }
}
- (void)controlOverlap:(TGBecons *)anchorTable
{
    NSArray *subviewsArray = [editorArea subviews];
    for (TGBecons *SingleView in subviewsArray) {
        if (anchorTable.tag != SingleView.tag) {
            [self isOverLapping:anchorTable targetTable:SingleView];
        }
    }
}
- (void)isOverLapping:(TGBecons *)anchorTable targetTable:(TGBecons *)targetTable
{
    
    if(CGRectIntersectsRect([anchorTable frame], [targetTable frame])) {
        
        [UIView animateWithDuration:0.2f
                         animations:^{
                             
                             float overlpX;
                             if(targetTable.frame.size.width + targetTable.frame.origin.x + 20.0f >= editorArea.frame.size.width){
                                 
                                 overlpX = editorArea.frame.origin.x + 30;
                                 
                             }else{
                                 
                                 overlpX = (targetTable.frame.size.width + targetTable.frame.origin.x + 20.0f);
                             }
                             
                             [anchorTable setFrame:CGRectMake(overlpX, anchorTable.frame.origin.y, anchorTable.frame.size.width, anchorTable.frame.size.height)];
                             
                             
                         }
         
                         completion:^(BOOL finished) {
                             [self controlOverlap:anchorTable];
                         }];
    } else {
        return;
    }
    return;
}

-(void)saveMapBecons
{
    SavedDataArray = [[NSMutableArray alloc]init];
    
    NSArray *tablesArray = [editorArea subviews];
    DebugLog(@"tablearray-------> %@",tablesArray);
    for (TGBecons *singleView in tablesArray) {
        if ([singleView isKindOfClass:[TGBecons class]]) {
            
            DebugLog(@"x----: %@-------: %@", [singleView ButtonLabel],[NSNumber numberWithFloat:[singleView frame].origin.x]);
            SavedDict = [[NSMutableDictionary alloc]init];
            
            
            SavedDict  = [[NSMutableDictionary alloc]initWithObjectsAndKeys:[singleView ButtonLabel],@"Name",
                          [singleView DescriptionText],@"Description",
                          [NSNumber numberWithFloat:[singleView frame].origin.x],@"Starx",
                          [NSNumber numberWithFloat:[singleView frame].origin.y],@"Stary",
                          [NSNumber numberWithFloat:[singleView frame].size.width],@"Starwidth",
                          [NSNumber numberWithFloat:[singleView frame].size.height],@"Starheight",
                          nil];
            
            [SavedDataArray addObject:SavedDict];
            
            [EditView setHidden:YES];
        }
    }
    
//        TGimageViewController *IMAGE =[[TGimageViewController alloc]init];
//        [IMAGE setImageset:img];
//        [self.navigationController pushViewController:IMAGE animated:YES];
    
    DebugLog(@"savedataarray----------- :%@", SavedDataArray);
}
- (UIImage *) imageWithView:(UIView *)view
{
    UIGraphicsBeginImageContext(view.bounds.size);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    img = UIGraphicsGetImageFromCurrentImageContext();
    
    DebugLog(@"image---: %@",img);
    
    UIGraphicsEndImageContext();
    
    return img;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    
    
    // Dispose of any resources that can be recreated.
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
    
}
- (BOOL) textField: (UITextField *)theTextField shouldChangeCharactersInRange: (NSRange)range replacementString: (NSString *)string
{
    
    searchtext = [NSString stringWithFormat:@"%@",[SearchTextfield.text stringByReplacingCharactersInRange:range withString:string]];
    
    
    if ([searchtext isEqualToString:@""]) {
        
        [searchtableview setHidden:YES];
    }
    else{
        [searchtableview setHidden:NO];
    }
    [self data];
    return YES;
}
-(void)data
{
    
    [downloadQueue addOperationWithBlock:^{
        
        NSError *error = nil;
        
        NSData *searchdata = [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/autocomplete/json?input=%@&key=AIzaSyCIrFex6nrxUygg6QS31p0cYC-nS6pV6QI",[searchtext stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]] options:NSDataReadingUncached error:&error];
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:searchdata options:kNilOptions error:&error];
        
        DebugLog(@"dict---%@", dict);
        
        searchresult = [dict objectForKey:@"predictions"];
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            
            [searchtableview reloadData];
        }];
        
    }];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return searchresult.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0.0f, 0.0f, 350.0f, 30.0f)];
    [label setBackgroundColor:[UIColor clearColor]];
    [label setText:[NSString stringWithFormat:@"%@",[[searchresult objectAtIndex:indexPath.row]objectForKey:@"description"]]];
    [label setTextAlignment:NSTextAlignmentLeft];
    [label setTextColor:[UIColor blackColor]];
   // [label setFont:[UIFont fontWithName:GLOBALTEXTFONT size:15]];
    label.tag = indexPath.row;
    [cell addSubview:label];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    SearchTextfield.text = [NSString stringWithFormat:@"%@",[[searchresult objectAtIndex:indexPath.row]objectForKey:@"description"]];
    [searchtableview setHidden:YES];
    [SearchTextfield resignFirstResponder];
    
}
-(void)Search:(UIButton *)sender
{
    if ([SearchTextfield.text isEqualToString:@""])
    {
        
    }
    else
    {
        DebugLog(@"field,,,, %@", SearchTextfield.text);
        
        
        NSString *esc_addr =  [SearchTextfield.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        NSError *error = nil;
        
        NSData *adressdata = [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://maps.google.com/maps/api/geocode/json?sensor=false&address=%@", esc_addr]] options:NSDataReadingUncached error:&error];
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:adressdata options:kNilOptions error:&error];
        
        array = [[NSMutableArray alloc]init];
        
        array = [dict objectForKey:@"results"];
        
        
        
        GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:[[NSString stringWithFormat:@"%@",[[[[array objectAtIndex:0]objectForKey:@"geometry"]  objectForKey:@"location"] objectForKey:@"lat"]] floatValue]
                                                                longitude:[[NSString stringWithFormat:@"%@",[[[[array objectAtIndex:0]objectForKey:@"geometry"]  objectForKey:@"location"] objectForKey:@"lng"]] floatValue]
                                                                     zoom:18];
        mapView_.camera = camera;
    }
}
#pragma mark - GMDraggableMarkerManagerDelegate.
- (void)mapView:(GMSMapView *)mapView didBeginDraggingMarker:(GMSMarker *)marker
{
    DebugLog(@">>> mapView:didBeginDraggingMarker: %@", [marker description]);
}
- (void)mapView:(GMSMapView *)mapView didDragMarker:(GMSMarker *)marker
{
    DebugLog(@">>> mapView:didDragMarker: %@", [marker description]);
}
- (void)mapView:(GMSMapView *)mapView didEndDraggingMarker:(GMSMarker *)marker
{
    DebugLog(@">>> mapView:didEndDraggingMarker: %@", [marker description]);
}
- (void)mapView:(GMSMapView *)mapView didCancelDraggingMarker:(GMSMarker *)marker
{
    DebugLog(@">>> mapView:didCancelDraggingMarker: %@", [marker description]);
}
-(void)mapView:(GMSMapView *)mapView didChangeCameraPosition:(GMSCameraPosition*)position {
    zoommap = mapView_.camera.zoom;
    
    DebugLog(@"zoom gms---- %d", zoommap);
    // handle you zoom related logic
}

-(void)BackButton:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)Settings:(UIButton *)sender
{
    
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
