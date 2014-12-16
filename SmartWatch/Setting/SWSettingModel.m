//
//  SWSettingModel.m
//  SmartWatch
//
//  Created by zhuzhi on 14/12/13.
//
//

#import "SWSettingModel.h"
#import "WBDatabaseService.h"
#import "WBSQLBuffer.h"
#import "SWSETTING.h"
#import "SWSettingInfo.h"

@implementation SWSettingModel

- (instancetype)initWithResponder:(id)responder {
    self = [super initWithResponder:responder];
    if (self) {
        WBSQLBuffer *sqlBuffer = [[WBSQLBuffer alloc] init];
        sqlBuffer.SELECT(@"*").FROM(DBSETTING._tableName);
        WBDatabaseTransaction *transaction = [[WBDatabaseTransaction alloc] initWithSQLBuffer:sqlBuffer];
        [[WBDatabaseService defaultService] readWithTransaction:transaction completionBlock:^{}];
        if (transaction.resultSet.resultArray.count > 0) {
            [[SWSettingInfo shareInstance] loadDataWithDictionary:transaction.resultSet.resultArray.firstObject];
        }
    }
    
    return  self;
}

- (void)updateToDB {
    WBMutableSQLBuffer *mutableSqlBuffer = [[WBMutableSQLBuffer alloc] init];
    
    WBSQLBuffer *deleteSqlbuffer = [[WBSQLBuffer alloc] init];
    deleteSqlbuffer.DELELTE(DBSETTING._tableName).WHERE([NSString stringWithFormat:@"1=1"]);
    [mutableSqlBuffer addBuffer:deleteSqlbuffer];
    
    WBSQLBuffer *sqlBuffer = [[WBSQLBuffer alloc] init];
    sqlBuffer.INSERT(DBSETTING._tableName);
    sqlBuffer.SET(DBSETTING._TARGETSTEP,@([[SWSettingInfo shareInstance] stepsTarget]));
    sqlBuffer.SET(DBSETTING._DAYTIMESTARTHOUR,@([SWSettingInfo shareInstance].startHour));
    sqlBuffer.SET(DBSETTING._DAYTIMEENDTHOUR,@([SWSettingInfo shareInstance].endHour));
    [mutableSqlBuffer addBuffer:sqlBuffer];
    
    WBDatabaseTransaction *transaction = [[WBDatabaseTransaction alloc] initWithMutalbeSQLBuffer:mutableSqlBuffer];
    
    [[WBDatabaseService defaultService] writeWithTransaction:transaction completionBlock:^{
    }];
    
}

- (void)saveStepsTarget:(NSInteger)steps {
    [[SWSettingInfo shareInstance] setStepsTarget:steps];
    [self updateToDB];
}

- (void)saveDaylightTimeWithStartHour:(NSInteger)startHour endHour:(NSInteger)endHour {
    [[SWSettingInfo shareInstance] setStartHour:startHour];
    [[SWSettingInfo shareInstance] setEndHour:endHour];
    [self updateToDB];
}

@end