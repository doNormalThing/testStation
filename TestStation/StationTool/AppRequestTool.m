//
//  AppRequestTool.m
//  TestStation
//
//  Created by 胡翔 on 2021/3/1.
//

#import "AppRequestTool.h"
#import "UUIDTool.h"
#import "MD5.h"
#import "MJExtension.h"
#import "StationConfig.h"
@implementation AppRequestTool
+(void)POST:(NSString *)URLString parameters:(NSMutableDictionary *)param andCom:(NSMutableDictionary *)com andUsr:(NSMutableDictionary *)usr andPr:(NSMutableDictionary *)pr andEvent:(NSString *)event finished:(void (^)(RequestResult *result))block{
    
    NSNumber *time = [NSNumber numberWithLong:(long)[[NSDate date] timeIntervalSince1970]];

//    NSDictionary *dic = @{
//        @"origin_id":@"",
//        @"imei":[UUIDTool getUUIDInKeychain],
//      };
//    dic = @{
//        @"origin_id":@"111",
//        @"imei":@"aaaa"
//    };
    if (!com) { // 公共参数
        com = [NSMutableDictionary dictionary];
    }
    if (!param) {
        param = [NSMutableDictionary dictionary];
    }
    
    [com setObject:[UUIDTool getUUIDInKeychain] forKey:@"imei"]; // 设备编号
    [com setObject:ORIGIN_ID forKey:@"origin_id"]; // 商户系统用户ID
    [com setObject:time forKey:@"event_time"]; // 事件写入时间
    [com setObject:@(1) forKey:@"event_duration"]; // 事件时长
    [com setObject:time forKey:@"event_start_time"]; // 事件触发时间
    [com setObject:@"SDK类型" forKey:@"sdk_type"]; // SDK类型
    [com setObject:@"SDK版本" forKey:@"sdk_version"]; // SDK版本
    [com setObject:@"https://www.baidu.com?aa=as&utm_source=111" forKey:@"url"]; // 页面地址

    //
    
    
    
    
    
    
    NSString *distinct_id = [[NSUserDefaults standardUserDefaults] objectForKey:DISTINCT_ID];
    if (distinct_id) {
        [com setObject:distinct_id forKey:DISTINCT_ID];
    }
    NSString *session_id = [[NSUserDefaults standardUserDefaults] objectForKey:SESSION_ID];
    if (session_id) {
        [com setObject:session_id forKey:SESSION_ID];
    }
    
    // 公共参数
   // 公共参数转json
    NSString *com_json = [AppRequestTool stringWithDict:com];
    // 公共参数md5
    NSString *com_md5 = [MD5 md532BitLower:com_json];
    
    
    
    // 用户属性
    NSString *usr_md5;
    if (usr) {
        [usr setObject:ORIGIN_ID forKey:@"origin_id"];
        // 用户属性转json
        NSString *usr_json = [AppRequestTool stringWithDict:usr];
        // 公共参数md5
        usr_md5 = [MD5 md532BitLower:usr_json];
    }
    
    
    // 事件属性
    NSString *pr_md5;
    if (pr) {
        // 用户属性转json
        NSString *pr_json = [AppRequestTool stringWithDict:pr];
        // 公共参数md5
        pr_md5 = [MD5 md532BitLower:pr_json];
    }
    
    
    
    NSString *pl = @"ios";
    NSString *ak = business_AK;
    NSString *key_str_md5;
    if (event) {
        key_str_md5 = [MD5 md532BitLower:[NSString stringWithFormat:@"%@%@%@%@",ak,pl,event,time]];
    } else {
        key_str_md5 = [MD5 md532BitLower:[NSString stringWithFormat:@"%@%@%@",ak,pl,time]];

    }
    
    
    // 用户属性
    if (usr_md5) {
       com_md5 = [MD5 md532BitLower:[NSString stringWithFormat:@"%@%@",usr_md5,com_md5]];
    }
    //时间属性
    if (pr_md5) {
        com_md5 = [MD5 md532BitLower:[NSString stringWithFormat:@"%@%@",pr_md5,com_md5]];
    }
    
    
    
    NSString *validator_sign_md5 = [MD5 md532BitLower:[NSString stringWithFormat:@"%@%@",key_str_md5,com_md5]];
    [param setObject:pl forKey:@"pl"];
    [param setObject:ak forKey:@"ak"];
    [param setObject:time forKey:@"time"];
    [param setObject:com forKey:@"com"];
    if (usr) {
    [param setObject:usr forKey:@"usr"];
    }
    if (pr) {
      [param setObject:pr forKey:@"pr"];

    }
    if (event) {
        [param setObject:event forKey:@"event"];

    }

//    NSDictionary *param = @{
//        @"ak":ak,
//        @"pl":pl,
//        @"com":com
//    };
//    param = @{@"ak":@"232c6fdc2826f7b77c28a23d7cb11fbd",@"com":@{@"imei":@"aaaa",@"origin_id":@"111"},@"pl":@"js",@"time":@(1614675329)
//
//    };
    NSLog(@"%@",param);
    NSDictionary *head = @{
        @"Accept":@"application/vnd.scrm.v1+json",
        @"Content-Type":@"application/json",
        @"sign":validator_sign_md5
    };
  
    
    

   

    [AFNetWorkTool POST:URLString parameters:param head:head callBackBlock:^(BOOL success, NSURLSessionDataTask *task, id responseObject, NSError *error) {
        
        [AppRequestTool handleAjaxResult:success task:task data:responseObject error:error finished:block];
    }];
}
+(void)handleAjaxResult:(BOOL)success task:(NSURLSessionDataTask *)task data:(id)responseObject error:(NSError *)error finished:(void (^)(RequestResult *result))block{
//    NSString *receiveStr = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
//    NSLog(@"%@",receiveStr);
    RequestResult *result = [[RequestResult alloc] init];
//    if ([responseObject isKindOfClass:[NSDictionary class]]) {
//        NSDictionary *dic = responseObject;
//
//    }
//
    
    if (success) {
        result = [RequestResult mj_objectWithKeyValues:responseObject];

    }
    if (result.code == 0) {
        if (result.data[DISTINCT_ID]) {
            NSString *distinct_id = result.data[DISTINCT_ID];
            [[NSUserDefaults standardUserDefaults] setValue:distinct_id forKey:DISTINCT_ID];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
        if (result.data[SESSION_ID]) {
            NSString *distinct_id = result.data[SESSION_ID];
            [[NSUserDefaults standardUserDefaults] setValue:distinct_id forKey:DISTINCT_ID];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
        
        
    }
    
      
    result.originDatas = responseObject;
    block(result);
}
+(NSString*)stringWithDict:(NSDictionary*)dict{
    
    NSArray*keys = [dict allKeys];
    
    NSArray*sortedArray = [keys sortedArrayUsingComparator:^NSComparisonResult(id obj1,id obj2) {
        return[obj1 compare:obj2 options:NSNumericSearch];//正序
    }];
    
    NSString*str =@"";
    
    for(NSString*categoryId in sortedArray) {
        
        id value = [dict objectForKey:categoryId];
        
        if([value isKindOfClass:[NSDictionary class]]) {
            
            value = [self stringWithDict:value];
            
        }
        
        if([str length] !=0) {
            
            str = [str stringByAppendingString:@","];
            
        }
        
        str = [str stringByAppendingFormat:@"\"%@\":\"%@\"",categoryId,value];
        
    }
    
     
    str = [NSString stringWithFormat:@"{%@}",str];

    return str;
}
@end
