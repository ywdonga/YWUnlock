# YWUnlock
#1.手势密码
####API
```
/** 是否已经创建过手势密码 */
+ (BOOL)haveGesturePassword;

/** 获取手势密码 */
+ (NSString *)getGesturesPassword;

/** 删除手势密码 */
+ (void)deleteGesturesPassword;

/**
展示 手势密码视图
@param type 类型 (YWUnlockViewCreate,//创建手势密码 YWUnlockViewUnlock//解锁手势密码)
*/
+ (void)showUnlockViewWithType:(YWUnlockViewType)type callBack:(CallBackBlock)callBack;
```
####使用方法
```
//创建手势密码
[YWUnlockView showUnlockViewWithType:YWUnlockViewCreate callBack:^(BOOL result) {
NSLog(@"-->%@",@(result));
}];
```
```
//验证手势密码
[YWUnlockView showUnlockViewWithType:YWUnlockViewUnlock callBack:^(BOOL result) {
NSLog(@"-->%@",@(result));
}];
```
#2.指纹验证
关于[指纹验证](http://www.jianshu.com/p/bc876a3969c0),之前一篇文章已经写过,这里简单封装了下
####使用方法
```
[YWFingerprintVerification fingerprintVerificationCallBack:^(NSError *error) {
if(!error){
NSLog(@"指纹验证通过");
}else{
NSLog(@"指纹验证失败->%@", @(error.code));
}
}];
```
####代码如下
YWFingerprintVerification.h
```
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
```
YWFingerprintVerification.m
```
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
```
