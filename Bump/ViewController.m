//
//  ViewController.m
//  Bump
//
//  Created by Apprentice on 7/18/15.
//  Copyright (c) 2015 Bump Boys!, Inc. All rights reserved.
//

#import "ViewController.h"
#import "Cell.h"
#import "AppDelegate.h"
@import CoreLocation;
//#import <CoreLocation/CoreLocation.h>

@interface ViewController () <CLLocationManagerDelegate>

@property (strong, nonatomic) CLLocationManager *locationManager;


@end

@implementation ViewController



/// ASYNCHRONOUS REQUEST CODE ///

-(void)makeRequest:(NSString*)string
{
//    NSLog(@"TEST");
    //    NSString *latStr = [NSString stringWithFormat:@"%f",lat];
    //    NSString *lonStr = [NSString stringWithFormat:@"%f", lon];
    //    NSString *location = [latStr stringByAppendingString:[@"&lon=" stringByAppendingString:lonStr]];
    //    [NSThread sleepForTimeInterval:5.0f];
    NSString *location = string;
    //     NSString *prefix = @"https://whispering-stream-9304.herokuapp.com/distance?lat=";
    NSString *prefix = @"https://whispering-stream-9304.herokuapp.com/update?token=7e4cdfd5e12553d49e55e33e17ee8f760415583f46c758b2fb9360afcaf26c8d&lat=";
    NSString *queryString = [prefix stringByAppendingString:location];
    
    
    
    //    7e4cdfd5e12553d49e55e33e17ee8f760415583f46c758b2fb9360afcaf26c8d
    [NSURLConnection sendAsynchronousRequest:
     [NSURLRequest requestWithURL:
      [NSURL URLWithString:queryString]]
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler: ^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                               id foo = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                               NSLog(@"*********************This is what we want%@",foo[@"dist_in_feet"]);
                               //    [self.myTextField setText:[NSString stringWithFormat:@"%@", foo[@"dist_in_feet"]]];
                           }];
  
}


//// LOCATION CODE /////

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
//        NSLog(@"TEst");
    //    NSLog(@"%@", [locations lastObject]);
    //    BOOL locationOn = [CLLocationManager locationServicesEnabled];
    //    locationManager update as location
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    [locationManager startUpdatingLocation];
    [locationManager stopUpdatingLocation];
    
    CLLocation *location = [locationManager location];
    // Configure the new event with information from the location
    NSLog(@"This is the location object %@", [location description]);
    CLLocationCoordinate2D coordinate = [location coordinate];
    
    float longitude=coordinate.longitude;
    float latitude=coordinate.latitude;
    
    
    [self performSelector:@selector(makeRequest:) withObject: [NSString stringWithFormat:@"%f&lon=%f",latitude,longitude] afterDelay:1.0];
    //
//        [NSTimer scheduledTimerWithTimeInterval: 10.0
//                                         target: self
//                                       selector:@selector(makeRequest:)
//                                       userInfo:[NSString stringWithFormat:@"%f.8&lon=%f.8",latitude,longitude]
//                                        repeats:YES];
    //
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
//    NSLog(@"GLOBAL VARIABLE TEST");
//    NSLog(MYGlobalVariable);
    
    self.dataArray =
    @[@"http://cdn9.staztic.com/app/a/3421/3421569/puppy-dogs-live-wallpaper-1-l-78x78.png",
      @"http://images6.fanpop.com/image/photos/36100000/sleeping-puppy-dogs-36143055-1024-768.jpg",
      @"http://cdn9.staztic.com/app/a/3421/3421569/puppy-dogs-live-wallpaper-1-l-78x78.png",
      @"http://cdn9.staztic.com/app/a/3421/3421569/puppy-dogs-live-wallpaper-1-l-78x78.png",
      @"http://cdn9.staztic.com/app/a/3421/3421569/puppy-dogs-live-wallpaper-1-l-78x78.png",
      @"http://cdn9.staztic.com/app/a/3421/3421569/puppy-dogs-live-wallpaper-1-l-78x78.png"];
    
    // This conditional block of code is for push notifications
    if ([[UIApplication sharedApplication] respondsToSelector:@selector(registerUserNotificationSettings:)])
    {
        // iOS 8 Notifications
        // use registerUserNotificationSettings
        [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge) categories:nil]];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    }
    else
    {
        // iOS < 8 Notifications
        // use registerForRemoteNotifications
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes: UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert];
    }
    
  
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    // Check for iOS 8. Without this guard the code will crash with "unknown selector" on iOS 7.
    // This is the notification block of code specifically for location.
    if ([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
        [self.locationManager requestAlwaysAuthorization];
    }
    
    [self.locationManager startUpdatingLocation];
    //    [self.locationManager startUpdatingLocation];
    

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


// HEADER CODE ///

/// The header won't show up without the following and a datasource method. 
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    MySupplementaryViewCollectionReusableView *header = nil;
    if ([kind isEqual:UICollectionElementKindSectionHeader])
    {
        header = [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                                    withReuseIdentifier:@"MyHeader"
                                                           forIndexPath:indexPath];
        
//        UIImage *headerImage = [UIImage imageNamed:@"background_image.jpg"];
//        header.backgroundImage.image = headerImage;
        header.headerLabel.text = @"Bump";
    }
    return header;
}



// THESE ARE THE COLLECTION VIEW DELEGATE METHODS, I ASSUME THEY ARE THE ONES THAT MANAGE THE CELLS
// I don't know how or where the fuck these methods are invoked.


-(NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
// This defines that amount of sections - i.e. the organizing thing surrounding the cells.
// A section contains cells (or, more generally, items).
// There is only one section. It's our CollectionViewController (I think).
    
    return 1;
}


-(NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
// This counts the number of items that will go in our section.
// It will match the number of data elements in the source.
    
    return self.dataArray.count;
}

-(UICollectionViewCell*) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
// I think this returns the individual cell objects from our view.
    Cell *aCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"myCell" forIndexPath:indexPath];
// This is the part where the aCell variable is assigned to a given cell.
    //         aCell.myLabel.text = self.dataArray[indexPath.row];
    //         aCell.image.image = [UIImage imageNamed:@"macaluso.jpeg"];  <--- Original methods
    //         aCell.image.image = self.dataArray[indexPath.row];
    //         NSString *path = self.dataArray[indexPath.row];
    //         aCell.image.image = [UIImage imageNamed:path];
    //         self.dataArray[indexPath.row];
    
    aCell.image.image = [UIImage imageWithData:
                        [NSData dataWithContentsOfURL:
                        [NSURL URLWithString:self.dataArray[indexPath.row]]]];
//THIS IS THE BIGG ONE! This method iterates over the self.dataArray and sets each image to the cell.

    //    cell.layer setBorderWidth:1.0f];
        [aCell.layer setBorderColor:[UIColor whiteColor].CGColor];
        [aCell.layer setCornerRadius:25.0f]; // MAKES CIRCLES!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

    
    return aCell;
}






@end
