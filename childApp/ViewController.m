//
//  ViewController.m
//  childApp
//
//  Created by harry bloch on 2/2/16.
//  Copyright © 2016 harry bloch. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize userID,locationManager,latitude,longitude,location,radius,jSong,userName;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)startLocation:(id)sender {
    self.userID = userName.text;
    [self startLocationManager];
    
}

-(void)startLocationManager {
    locationManager = [[CLLocationManager alloc]init];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [locationManager requestAlwaysAuthorization];
    [locationManager startUpdatingLocation];
}


-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    location = [locations lastObject];
    latitude = [[NSNumber alloc]init];
    longitude= [[NSNumber alloc]init];
    latitude = [NSNumber numberWithDouble:location.coordinate.latitude];
    longitude = [NSNumber numberWithDouble:location.coordinate.longitude];
    [self convertDictionary];
    [self patchData];
}

-(void)convertDictionary {
    NSDictionary *userDetails = @{
                                  @"utf8" : @"✓",
                                  @"authenticity_token" : @"EvZva3cKnzo3Y0G5R3NktucCr99o/2UWOPVAmJYdBOc=",
                                  @"user": @{
                                          @"username" : self.userID,
                                          @"current_lat" : self.latitude,
                                          @"current_longitude" : self.longitude,
                                          },
                                  @"commit" : @"Create User",
                                  @"action" : @"update",
                                  @"controller" : @"users"
                                  };
    //convert to json
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:userDetails options:NSJSONWritingPrettyPrinted error:&error];
    if (! jsonData)
    {
        NSLog(@"Gor an error: %@",error);
    }else
    {
        NSString *jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
        NSLog(@"JSON TEST->%@",jsonString);
        self.jSong = jsonString;
    }
}

-(void)patchData {
    NSString *urlString = [NSString stringWithFormat:@"http://protected-wildwood-8664.herokuapp.com/users/%@",userID];
    NSMutableURLRequest *patchRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    [patchRequest setValue:@"application/json" forHTTPHeaderField:@"content-type"];
    [patchRequest setHTTPMethod:@"PATCH"];
    [patchRequest setHTTPBody:[NSData dataWithBytes:[self.jSong UTF8String] length:strlen([self.jSong UTF8String])]];
    NSURLConnection *connections = [[NSURLConnection alloc]initWithRequest:patchRequest delegate:self];
    NSLog(@"%@",patchRequest);
}

@end
























