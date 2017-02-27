//
//  ViewController.m
//  YWUnlock
//
//  Created by dyw on 2017/2/24.
//  Copyright © 2017年 dyw. All rights reserved.
//

#import "ViewController.h"
#import "YWUnlockView.h"
#import "YWFingerprintVerification.h"

@interface ViewController ()


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    [YWFingerprintVerification fingerprintVerificationCallBack:^(NSError *error) {
        if(!error){
            NSLog(@"指纹验证通过");
        }else{
            NSLog(@"指纹验证失败->%@", @(error.code));
        }
    }];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)creat:(id)sender {
    //创建手势密码
    [YWUnlockView showUnlockViewWithType:YWUnlockViewCreate callBack:^(BOOL result) {
        NSLog(@"-->%@",@(result));
    }];
}

- (IBAction)outh:(id)sender {
    //验证手势密码
    [YWUnlockView showUnlockViewWithType:YWUnlockViewUnlock callBack:^(BOOL result) {
        NSLog(@"-->%@",@(result));
    }];

}


@end
