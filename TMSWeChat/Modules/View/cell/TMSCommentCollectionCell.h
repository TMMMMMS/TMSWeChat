//
//  TMSCommentCollectionCell.h
//  TMSWeChat
//
//  Created by TmmmS on 2019/5/19.
//  Copyright © 2019年 TMS. All rights reserved.
//

#import "TMSDiscoverCollectionCell.h"
@class TMSCommentCollectionCellViewModel;

NS_ASSUME_NONNULL_BEGIN

@interface TMSCommentCollectionCell : TMSDiscoverCollectionCell
@property(nonatomic, readonly, strong) TMSCommentCollectionCellViewModel *viewModel;

- (void)bindViewModel:(TMSCommentCollectionCellViewModel *)viewModel isShowLine:(BOOL)isShowLine;

@end

NS_ASSUME_NONNULL_END
