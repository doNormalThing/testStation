//
//  AFNetWorkTool.m
//  TestStation
//
//  Created by 胡翔 on 2021/3/1.
//

#import "AFNetWorkTool.h"

@implementation AFNetWorkTool
+(AFHTTPSessionManager *)shareAFNManager {
    static AFHTTPSessionManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        manager = [AFHTTPSessionManager manager];
    });
    return manager;
}
+ (NSDictionary *)getheadParam {
    
    return @{};
   
}
+(void)POST:(NSString *)URLStr parameters:(NSDictionary *)parameters head:(NSDictionary *)head callBackBlock:(void (^)(BOOL success ,NSURLSessionDataTask *task, id responseObject, NSError *error))callBackBlock{
    
    
    AFHTTPSessionManager *manager = [AFNetWorkTool shareAFNManager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
//    NSMutableURLRequest *req  = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:URLStr parameters:parameters error:nil];
//    [req setValue:@"application/vnd.scrm.v1+json" forHTTPHeaderField:@"Accept"];
//    [req setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
//    [req setValue:@"232c6fdc2826f7b77c28a23d7cb11fbd" forHTTPHeaderField:@"sign"];
    
//
//    manager.responseSerializer = [AFJSONResponseSerializer serializer];
//    [manager.requestSerializer setValue:@"raw" forHTTPHeaderField:@"Content-Type"];
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:parameters options:NSJSONWritingPrettyPrinted error:&error];
    
    
    NSLog(@"%@",parameters);
    NSLog(@"%@",head);
    
    
    
    
    
    
    
    
    
    
    
    
    
     
        [manager POST:URLStr parameters:parameters headers:head progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
           callBackBlock(YES,task,responseObject,nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        callBackBlock(NO,task,nil,nil);
    }];
    
    
}
@end
