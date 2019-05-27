//
//  TMSHelper.m
//  TMSWeChat
//
//  Created by TmmmS on 2019/5/23.
//  Copyright © 2019年 TMS. All rights reserved.
//

#import "TMSHelper.h"
#import "AppDelegate.h"

@implementation TMSHelper

+ (UIEdgeInsets)safeAreaInsets {
    if (@available(iOS 11.0, *)) {
        static dispatch_once_t onceToken;
        static CGFloat statusBarFrameHeight;
        dispatch_once(&onceToken, ^{
            statusBarFrameHeight = CGRectGetHeight([UIApplication sharedApplication].statusBarFrame);
        });
        if (statusBarFrameHeight == 20) {
            return UIEdgeInsetsZero;
        }
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        return appDelegate.window.safeAreaInsets;
    } else {
        return UIEdgeInsetsZero;
    }
}

@end
