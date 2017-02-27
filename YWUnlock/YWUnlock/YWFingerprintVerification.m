//
//  YWFingerprintVerification.m
//  YWUnlock
//
//  Created by dyw on 2017/2/27.
//  Copyright © 2017年 dyw. All rights reserved.
//

#import "YWFingerprintVerification.h"

@implementation YWFingerprintVerification

+ (void)fingerprintVerificationCallBack:(void(^)(NSError *error))callBack;{
    //本地认证上下文联系对象
    LAContext * context = [[LAContext alloc] init];
    NSError * error = nil;
    //验证是否具有指纹认证功能，不建议使用版本判断方式实现
    BOOL canEvaluatePolicy = [context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error];
    if (error) {
        NSLog(@"%@", error.localizedDescription);
        !callBack?:callBack(error);
    }
    if (canEvaluatePolicy) {
        NSLog(@"有指纹认证功能");
        //匹配指纹
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:@"验证指纹已确认您的身份" reply:^(BOOL success, NSError *error) {
            if (success) {
                NSLog(@"指纹验证成功");
                !callBack?:callBack(nil);
            } else {
                NSLog(@"验证失败");
                NSLog(@"%@",error.localizedDescription);
                !callBack?:callBack(error);
            }
        }];
    } else {
        NSLog(@"无指纹认证功能");
    }
}

@end
