//
//  TMSInputView.h
//  TMSWeChat
//
//  Created by TmmmS on 2019/5/23.
//  Copyright © 2019年 TMS. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TMSCommentCollectionCellViewModel;

NS_ASSUME_NONNULL_BEGIN

@interface TMSInputView : UIView

@property(nonatomic, readonly, strong) RACSubject *textFieldSubject;
@property(nonatomic, readonly, strong) UITextField *textField;

+ (instancetype)shareInstance;
- (void)bindViewModel:(TMSCommentCollectionCellViewModel *)viewModel;
@end

NS_ASSUME_NONNULL_END
