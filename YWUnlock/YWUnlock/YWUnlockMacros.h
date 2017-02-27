//
//  YWUnlockMacros.h
//  YWUnlock
//
//  Created by dyw on 2017/2/25.
//  Copyright © 2017年 dyw. All rights reserved.
//

#ifndef YWUnlockMacros_h
#define YWUnlockMacros_h

#define YWUnlock_SW [UIScreen mainScreen].bounds.size.width
#define YWUnlock_SH [UIScreen mainScreen].bounds.size.height
#define YWUnlock_KW [UIApplication sharedApplication].keyWindow
#define YWUnlock_BD [NSBundle mainBundle]
#define YWUnlock_WKSELF __weak __typeof(self)weakSelf = self
#define YWUIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#endif /* YWUnlockMacros_h */
