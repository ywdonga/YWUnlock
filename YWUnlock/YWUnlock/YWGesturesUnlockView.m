//
//  YWGesturesUnlockView.m
//  YWUnlock
//
//  Created by dyw on 2017/2/25.
//  Copyright © 2017年 dyw. All rights reserved.
//

#import "YWGesturesUnlockView.h"

#define cols 3 //总列数
#define linColor 0xffc8ad //线条颜色
#define linWidth 8 //线条宽度

@interface YWGesturesUnlockView ()

@property (nonatomic, strong) NSMutableArray *selectedBtns;
@property (nonatomic, assign) CGPoint currentPoint;

@end

@implementation YWGesturesUnlockView

- (instancetype)initWithCoder:(NSCoder *)coder{
    self = [super initWithCoder:coder];
    if (self) {
        [self setup];
    }
    return self;
}

//为什么要在这个方法中布局子控件，因为只调用这个方法，就表示父控件的尺寸确定
- (void)layoutSubviews {
    [super layoutSubviews];
    NSUInteger count = self.subviews.count;
    CGFloat x = 0,y = 0,w = 0,h = 0;
    if (YWUnlock_SW == 320) {
        w = 50;
        h = 50;
    }else {
        w = 58;
        h = 58;
    }
    
    CGFloat margin = (self.bounds.size.width - cols * w) / (cols + 1);//间距
    CGFloat col = 0;
    CGFloat row = 0;
    for (int i = 0; i < count; i++) {
        col = i%cols;
        row = i/cols;
        x = margin + (w+margin)*col;
        y = margin + (w+margin)*row;
        if (YWUnlock_SH == 480) {
            y = (w+margin)*row;
        }else {
            y = margin +(w+margin)*row;
        }
        UIButton *btn = self.subviews[i];
        btn.frame = CGRectMake(x, y, w, h);
    }
}

//只要调用这个方法就会把之前绘制的东西清空 重新绘制
- (void)drawRect:(CGRect)rect {
    if (self.selectedBtns.count == 0) return;
    // 把所有选中按钮中心点连线
    UIBezierPath *path = [UIBezierPath bezierPath];
    NSUInteger count = self.selectedBtns.count;
    for (int i = 0; i < count; i++) {
        UIButton *btn = self.selectedBtns[i];
        if (i == 0) {
            [path moveToPoint:btn.center];
        }else {
            [path addLineToPoint:btn.center];
        }
    }
    [path addLineToPoint:_currentPoint ];
    [YWUIColorFromRGB(linColor) set];
    path.lineJoinStyle = kCGLineJoinRound;
    path.lineWidth = linWidth;
    [path stroke];
}

#pragma mark - private
- (void)setup {
    self.selectedBtns = [NSMutableArray array];
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [self addGestureRecognizer:pan];
    //创建9个按钮
    for (int i = 0; i < 9; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.userInteractionEnabled = NO;
        [btn setImage:[UIImage imageNamed:@"gesture_normal"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"gesture_selected"] forState:UIControlStateSelected];
        btn.tag = 1000+i;
        [self addSubview:btn];
    }
}

#pragma mark - action pan
- (void)pan:(UIPanGestureRecognizer *)pan {
    _currentPoint = [pan locationInView:self];
    [self setNeedsDisplay];
    for (UIButton *button in self.subviews) {
        if (CGRectContainsPoint(button.frame, _currentPoint) && button.selected == NO) {
            button.selected = YES;
            [self.selectedBtns addObject:button];
        }
    }
    [self layoutIfNeeded];
    if (pan.state == UIGestureRecognizerStateEnded) {
        //保存输入密码
        NSMutableString *gesturePwd = [NSMutableString string];
        for (UIButton *button in self.selectedBtns) {
            [gesturePwd appendFormat:@"%ld",button.tag-1000];
            button.selected = NO;
        }
        [self.selectedBtns removeAllObjects];
        //手势密码绘制完成后回调
        !self.drawRectFinishedBlock?:self.drawRectFinishedBlock(gesturePwd);
    }
}

@end
