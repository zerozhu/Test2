//
//  LocationTracker.h
//  Location
//
//  Created by Rick
//  Copyright (c) 2014 Location. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "LocationShareModel.h"

#define LocationTimeInterval 0.5f * 60.0f

extern NSString * const KNewLocationProducedNotification;

@interface LocationTracker : NSObject <CLLocationManagerDelegate>

//@property (nonatomic,strong) CLLocation *lastBestLocation;

@property (strong,nonatomic) LocationShareModel * shareModel;

//@property (nonatomic) CLLocationCoordinate2D myBestLocation;

+ (CLLocationManager *)sharedLocationManager;

- (void)startLocationTracking;
- (void)stopLocationTracking;
- (void)updateLocationToServer;


@end
