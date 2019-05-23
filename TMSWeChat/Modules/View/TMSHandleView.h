//
//  TMSHandleView.h
//  TMSWeChat
//
//  Created by TmmmS on 2019/5/23.
//  Copyright © 2019年 TMS. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TMSTimeCollectionCellViewModel;

NS_ASSUME_NONNULL_BEGIN

@interface TMSHandleView : UIView
@property(nonatomic, readonly, strong) TMSTimeCollectionCellViewModel *viewModel;

+ (instancetype)shareInstance;
- (void)bindViewModel:(TMSTimeCollectionCellViewModel *)viewModel;
- (void)showAnimation;
- (void)hideAnimation;
@end

NS_ASSUME_NONNULL_END
