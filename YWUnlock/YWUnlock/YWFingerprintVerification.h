//
//  YWFingerprintVerification.h
//  YWUnlock
//
//  Created by dyw on 2017/2/27.
//  Copyright © 2017年 dyw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <LocalAuthentication/LocalAuthentication.h>

/** error.code */
/** 
 typedef NS_ENUM(NSInteger, LAError)
 {
 //用户验证没有通过，比如提供了错误的手指的指纹
 LAErrorAuthenticationFailed = kLAErrorAuthenticationFailed,
 
 // 用户取消了Touch ID验证
 LAErrorUserCancel           = kLAErrorUserCancel,
 
 //用户不想进行Touch ID验证，想进行输入密码操作
 LAErrorUserFallback         = kLAErrorUserFallback,
 
 // 系统终止了验证
 LAErrorSystemCancel         = kLAErrorSystemCancel,
 
 // 用户没有在设备Settings中设定密码
 LAErrorPasscodeNotSet       = kLAErrorPasscodeNotSet,
 
 // 设备不支持Touch ID
 LAErrorTouchIDNotAvailable  = kLAErrorTouchIDNotAvailable,
 
 // 设备没有进行Touch ID 指纹注册
 LAErrorTouchIDNotEnrolled   = kLAErrorTouchIDNotEnrolled,
 } NS_ENUM_AVAILABLE(10_10, 8_0);
 */

@interface YWFingerprintVerification : NSObject

/**
 指纹验证
 @param callBack 验证结果
 */
+ (void)fingerprintVerificationCallBack:(void(^)(NSError *error))callBack;

@end
