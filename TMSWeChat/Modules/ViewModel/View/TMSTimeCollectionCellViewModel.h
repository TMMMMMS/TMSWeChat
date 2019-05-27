//
//  TMSTimeCollectionCellViewModel.h
//  TMSWeChat
//
//  Created by TmmmS on 2019/5/19.
//  Copyright © 2019年 TMS. All rights reserved.
//

#import "TMSBaseCellViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TMSTimeCollectionCellViewModel : TMSBaseCellViewModel

@property(nonatomic, readwrite, strong) RACSubject *clickActionSubject;
/// cell 上的事件处理
// 点赞action
@property (nonatomic, readwrite, strong) RACCommand *likeCommand;
// 评论action
@property (nonatomic, readwrite, strong) RACSubject *didClickedCommentSubject;
// 添加评论
@property (nonatomic, readwrite, strong) RACSubject *addCommentSubject;

@end

NS_ASSUME_NONNULL_END
