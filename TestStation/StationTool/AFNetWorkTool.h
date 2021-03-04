//
//  AFNetWorkTool.h
//  TestStation
//
//  Created by 胡翔 on 2021/3/1.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

NS_ASSUME_NONNULL_BEGIN

@interface AFNetWorkTool : NSObject
/**
 *  POST请求
 *  详细用法请参考 AFNetworking 框架
 *  @param URLStr 完整的请求路径
 *  @param parameters  参数
 *  @param callBackBlock     回调
 */
+(void)POST:(NSString *)URLStr parameters:(NSDictionary *)parameters head:(NSDictionary *)head callBackBlock:(void (^)(BOOL success ,NSURLSessionDataTask *task, id responseObject, NSError *error))callBackBlock;
@end

NS_ASSUME_NONNULL_END
