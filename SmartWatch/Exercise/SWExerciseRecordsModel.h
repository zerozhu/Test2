//
//  SWExerciseRecordsModel.h
//  SmartWatch
//
//  Created by zhuzhi on 14/12/10.
//
//

#import <Foundation/Foundation.h>
#import "SWModel.h"

@interface SWExerciseRecordsModel : SWModel

@property (nonatomic,readonly) NSInteger totalSteps;
@property (nonatomic,readonly) float totalDistance;
@property (nonatomic,readonly) float totalCalorie;
@property (nonatomic,readonly) NSDictionary *calorieDictionary;
@property (nonatomic,readonly) NSDictionary *stepsDictionary;
@property (nonatomic,readonly) NSDictionary *sleepDictionary;
@property (nonatomic,readonly) float caloriePercent;
@property (nonatomic,readonly) NSString *caloriePercentString;

@property (nonatomic,readonly) float stepsPercent;
@property (nonatomic,readonly) NSString *stepsPercentString;
@property (nonatomic,readonly) float daylightActivitytime;

@property (nonatomic,readonly) NSInteger deepSleepHour;
@property (nonatomic,readonly) NSInteger lightSleepHour;
@property (nonatomic,readonly) NSInteger nightActivityHour;
@property (nonatomic,readonly) float sleepPercent;

@property (nonatomic,readonly) NSDate *currentDate;
@property (nonatomic,readonly) NSString *currentDateString;

@property (nonatomic,readonly) NSArray *locationArray;

@property (nonatomic,readonly) NSString *uvLevel;
@property (nonatomic,readonly) NSString *temp;
@property (nonatomic,readonly) NSString *shidu;

- (void)queryExerciseRecordsWithDate:(NSDate *)date;
- (void)queryLocationWithDate:(NSDate *)date;
- (void)queryWeatherInfo;

@end
