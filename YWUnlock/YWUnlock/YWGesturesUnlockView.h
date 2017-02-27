//
//  YWGesturesUnlockView.h
//  YWUnlock
//
//  Created by dyw on 2017/2/25.
//  Copyright © 2017年 dyw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YWUnlockMacros.h"

@interface YWGesturesUnlockView : UIView

@property (nonatomic, copy) void(^drawRectFinishedBlock)(NSString *gesturePassword);

@end
