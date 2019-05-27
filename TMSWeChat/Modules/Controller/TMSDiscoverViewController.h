//
//  TMSDiscoverViewController.h
//  TMSWeChat
//
//  Created by TmmmS on 2019/5/19.
//  Copyright © 2019年 TMS. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TMSDiscoverViewModel;

NS_ASSUME_NONNULL_BEGIN

@interface TMSDiscoverViewController : UIViewController
@property (nonatomic, readonly, strong) IGListAdapter *adapter;
- (instancetype)initWtihViewModel:(TMSDiscoverViewModel *)viewModel;
@end

NS_ASSUME_NONNULL_END
