//
//  RequestResult.h
//  TestStation
//
//  Created by 胡翔 on 2021/3/1.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RequestResult : NSObject

typedef enum : NSUInteger {
    AjaxStateSuccess  = 0, // 成功

 

     
    
    
} AjaxState;

/**
 *  对应的状态
 */
@property(assign,nonatomic) AjaxState code;

/**
 *  字典数据(业务数据)
 */
@property(strong,nonatomic) id data;
/**
 *  信息提示
 */
@property(strong,nonatomic) NSString *message;

/**
 *  请求回来的原生数据
 */
@property (nonatomic, strong) id originDatas;

@property (nonatomic, assign) int status;

@end

NS_ASSUME_NONNULL_END
