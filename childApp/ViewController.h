//
//  ViewController.h
//  childApp
//
//  Created by harry bloch on 2/2/16.
//  Copyright © 2016 harry bloch. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>



@interface ViewController : UIViewController<CLLocationManagerDelegate, NSURLConnectionDelegate>
{
    NSMutableData * _responseData;
}

@property (nonatomic,strong) NSString *userID;
@property (nonatomic,strong) CLLocationManager *locationManager;
@property (nonatomic,strong) CLLocation* location;
@property (nonatomic,strong) NSNumber * latitude;
@property (nonatomic,strong) NSNumber * longitude;
@property (nonatomic,strong) NSString * radius;
@property (nonatomic,strong) NSString * jSong;


@property (weak, nonatomic) IBOutlet UITextField *userName;
- (IBAction)startLocation:(id)sender;

-(void)startLocationManager;
-(void)convertDictionary;


@end

