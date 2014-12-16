//
//  SWSettingInfo.h
//  SmartWatch
//
//  Created by zhuzhi on 14/12/13.
//
//

#import <Foundation/Foundation.h>
#import "SWSingleton.h"

@interface SWSettingInfo : NSObject

SW_AS_SINGLETON(SWSettingInfo, shareInstance);

@property (nonatomic) NSInteger stepsTarget;
@property (nonatomic) float calorieTarget;
@property (nonatomic) NSInteger startHour;
@property (nonatomic) NSInteger endHour;
@property (nonatomic) NSArray *alarmArray;

- (void)loadDataWithDictionary:(NSDictionary *)dictionary;

@end