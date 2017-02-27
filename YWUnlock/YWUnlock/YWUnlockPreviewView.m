//
//  YWUnlockPreviewView.m
//  YWUnlock
//
//  Created by dyw on 2017/2/24.
//  Copyright © 2017年 dyw. All rights reserved.
//

#import "YWUnlockPreviewView.h"

#define BTN_H 9
#define BTN_W 9

@interface YWUnlockPreviewView ()

@property (nonatomic, strong) NSMutableArray *buttons;

@end

@implementation YWUnlockPreviewView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder{
    self = [super initWithCoder:coder];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    NSUInteger count = self.subviews.count;
    int cols = 3;//总列数
    CGFloat x = 0,y = 0;//bounds
    CGFloat margin = (self.bounds.size.width - cols * BTN_W) / (cols + 1);//间距
    CGFloat col = 0;
    CGFloat row = 0;
    for (int i = 0; i < count; i++) {
        col = i%cols;
        row = i/cols;
        x = margin + (BTN_W+margin)*col;
        y = margin + (BTN_W+margin)*row;
        UIButton *btn = self.subviews[i];
        btn.frame = CGRectMake(x, y, BTN_W, BTN_H);
    }
}

- (void)setup{
    for (int i = 0; i < 9; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.userInteractionEnabled = NO;
        [btn setImage:[UIImage imageNamed:@"gesture_indicator_normal"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"gesture_indicator_selected"] forState:UIControlStateSelected];
        [self addSubview:btn];
        [self.buttons addObject:btn];
    }
}

- (void)setGesturesPassword:(NSString *)gesturesPassword{
    for (UIButton *button in self.buttons) {
        button.selected = NO;
    }
    for (int i = 0; i < gesturesPassword.length; i++) {
        NSInteger index = [gesturesPassword substringWithRange:NSMakeRange(i, 1)].integerValue;
        [self.buttons[index] setSelected:YES];
    }
}

- (NSMutableArray *)buttons {
    if (!_buttons) {
        _buttons = [NSMutableArray array];
    }
    return _buttons ;
}

@end
