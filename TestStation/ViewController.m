//
//  ViewController.m
//  TestStation
//
//  Created by 胡翔 on 2021/3/1.
//

#import "ViewController.h"
#import "AppRequestTool.h"
#import "UUIDTool.h"
#import "MD5.h"
#import "AFNetworking.h"
#import "StationConfig.h"
#import "SVProgressHUD.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//   
//    [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:@"https://devscrm.grazy.cn/open/heartbeat" parameters:parameters error:nil];
//    
//    return;
  
//    NSMutableOrderedSet *set = [[NSMutableOrderedSet alloc] init];
//    [set addObject:@{@"a":@"a"}];
//    [set addObject:@{@"c":@"c"}];
//
//    NSLog(@"%@",set);
    
    
    [self afRequest];
    
    
    
    
    
    
    
    

                   
    
    
}


- (void)afRequest {
//    NSString *interfaceName = @"https://devscrm.grazy.cn/open/heartbeat";
//    NSString *interfaceName = @"https://devscrm.grazy.cn/open/register";
    NSString *interfaceName = @"https://devscrm.grazy.cn/open/push";


   NSDictionary *param = @{@"ak":@"232c6fdc2826f7b77c28a23d7cb11fbd",
                           @"com":@{@"imei":@"aaaa",@"origin_id":@"111"},
                           @"pl":@"js",
                           @"time":@(1614675329)
              
    };
    NSMutableDictionary *usr = @{
        @"phone":@(17673045107),
        @"country":@"China"
    }.mutableCopy;
    
    
    NSMutableDictionary *pr = @{
         @"is_vip": @(true),
            @"platform_type": @"平台类型",
            @"product_name": @"产品名称",
            @"user_type": @"用户角色",
            @"vip_type": @"会员类型",
            @"course_name": @"课程名称",
            @"course_price": @(11.22),
            @"finish_time": @(1609046101),
            @"sum_payable": @(10.1),
            @"payment_duration": @(1)
    }.mutableCopy;
    NSString *event = @"BUSINESS_EVENT_event_buy_course_finish";
    
    [AppRequestTool POST:interfaceName parameters:nil andCom:nil andUsr:nil andPr:pr andEvent:event finished:^(RequestResult * _Nonnull result) {
        NSLog(@"");
        if (result.code == 0) {
           
        } else {
            [SVProgressHUD showErrorWithStatus:result.message];
        }
        
        
            
    }];
}



-(NSString*)stringWithDict:(NSDictionary*)dict{
    
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
- (void)originRequest {
    // 1.创建请求
        NSURL *url = [NSURL URLWithString:@"https://devscrm.grazy.cn/open/heartbeat"];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        request.HTTPMethod = @"POST";

       // 2.设置请求头
    [request setValue:@"application/vnd.scrm.v1+json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"7bea2562e0551cc89c0f99da8efe5a8f" forHTTPHeaderField:@"sign"];

//        // 3.设置请求体
//        NSDictionary *json = @{
//            @"ak":@"232c6fdc2826f7b77c28a23d7cb11fbd",
//            @"pl":@"js",
//            @"time":@"1614675329",
//            @"com":@"{\"imei\":\"aaaa\",\"origin_id\":\"111\"}",
//            };
    
    NSDictionary *json = @{@"ak":@"232c6fdc2826f7b77c28a23d7cb11fbd",@"com":@{@"imei":@"aaaa",@"origin_id":@"111"},@"pl":@"js",@"time":@(1614675329)};

    //    NSData --> NSDictionary
        // NSDictionary --> NSData
    NSData *data = [NSJSONSerialization dataWithJSONObject:json options:NSJSONWritingPrettyPrinted error:nil];
        request.HTTPBody = data;

        // 4.发送请求


        [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {

            NSString *newS = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"%@",newS);

        }];
    
    return;
}
@end
