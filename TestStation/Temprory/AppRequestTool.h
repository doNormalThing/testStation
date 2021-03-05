//
//  AppRequestTool.h
//  TestStation
//
//  Created by 胡翔 on 2021/3/1.
//

#import <Foundation/Foundation.h>
#import "AFNetWorkTool.h"
#import "RequestResult.h"
NS_ASSUME_NONNULL_BEGIN

@interface AppRequestTool : NSObject
/**
 
 */
+(void)POST:(NSString *)URLString parameters:(NSMutableDictionary *)param andCom:(NSMutableDictionary *)com andUsr:(NSMutableDictionary *)usr andPr:(NSMutableDictionary *)pr andEvent:(NSString *)event finished:(void (^)(RequestResult *result))block;
@end

NS_ASSUME_NONNULL_END
