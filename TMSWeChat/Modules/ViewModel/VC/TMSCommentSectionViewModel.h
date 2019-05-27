//
//  TMSCommentSectionModel.h
//  TMSWeChat
//
//  Created by TmmmS on 2019/5/20.
//  Copyright © 2019年 TMS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TMSDiscoverModel.h"

@class TMSDiscoverModel;
@class TMSCommentModel;
@class TMSCommentCollectionCellViewModel;

NS_ASSUME_NONNULL_BEGIN

@interface TMSCommentSectionViewModel : NSObject <IGListDiffable>

@property(nonatomic, readonly, strong) TMSDiscoverModel *discoverModel;

@property(nonatomic, readonly, assign) NSInteger comment_num;
// cell的viewModel
@property(nonatomic, readonly, strong) NSMutableArray <TMSCommentCollectionCellViewModel *>* viewModels;

- (instancetype)initWithDiscoverModel:(TMSDiscoverModel *)model;

// 模拟添加了一条评论
- (void)addCommentModel:(TMSCommentModel *)model;
@end

NS_ASSUME_NONNULL_END
