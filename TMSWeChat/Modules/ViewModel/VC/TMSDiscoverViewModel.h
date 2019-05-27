//
//  TMSDiscoverViewModel.h
//  TMSWeChat
//
//  Created by TmmmS on 2019/5/19.
//  Copyright © 2019年 TMS. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TMSDiscoverSectionViewModel;

NS_ASSUME_NONNULL_BEGIN

@interface TMSDiscoverViewModel : NSObject
@property(nonatomic, strong) NSMutableArray *discovers;

// 点击昵称
@property (nonatomic, readonly, strong) RACSubject *didClickedNameSubject;
// 点击照片
@property (nonatomic, readonly, strong) RACSubject *didClickedPicSubject;
/// DateCell 上的事件处理
@property(nonatomic, readonly, strong) RACSubject *clickActionSubject;
// 评论
@property (nonatomic, readonly, strong) RACSubject *didClickedCommentSubject;
@end

NS_ASSUME_NONNULL_END
