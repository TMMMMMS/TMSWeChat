//
//  TMSCommentCollectionCellViewModel.h
//  TMSWeChat
//
//  Created by TmmmS on 2019/5/19.
//  Copyright © 2019年 TMS. All rights reserved.
//

#import "TMSBaseCellViewModel.h"
@class TMSCommentModel;

NS_ASSUME_NONNULL_BEGIN

@interface TMSCommentCollectionCellViewModel : TMSBaseCellViewModel
// 评论
@property (nonatomic, readonly, copy) NSAttributedString *commentAttributedString;

- (instancetype)initWithCommentModel:(TMSCommentModel *)model;
@end

NS_ASSUME_NONNULL_END
