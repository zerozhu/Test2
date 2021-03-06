//
//  SWSETTING.h
//  SmartWatch
//
//  Created by zhuzhi on 14/12/13.
//
//

#import "WBEntityBase.h"
#import "SWSingleton.h"

#define DBSETTING [SWSETTING shareInstant]

@interface SWSETTING : WBEntityBase

@property (nonatomic,readonly)NSString *_TARGETSTEP;
@property (nonatomic,readonly)NSString *_TARGETCALORIE;
@property (nonatomic,readonly)NSString *_TARGETSLEEP;
@property (nonatomic,readonly)NSString *_DAYTIMESTARTHOUR;
@property (nonatomic,readonly)NSString *_DAYTIMEENDTHOUR;
@property (nonatomic,readonly)NSString *_ALARM;
@property (nonatomic,readonly)NSString *_LOSTMETERS;
@property (nonatomic,readonly)NSString *_PREVENTLOST;

SW_AS_SINGLETON(SWSETTING, shareInstant);

@end
