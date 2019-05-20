//
//  TMSCommentSectionModel.h
//  TMSWeChat
//
//  Created by TmmmS on 2019/5/20.
//  Copyright © 2019年 TMS. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TMSDiscoverModel;
@class TMSCommentCollectionCellViewModel;

NS_ASSUME_NONNULL_BEGIN

@interface TMSCommentSectionViewModel : NSObject <IGListDiffable>

@property(nonatomic, readonly, assign) NSInteger comment_num;
// cell的viewModel
@property(nonatomic, readonly, strong) NSArray <TMSCommentCollectionCellViewModel *>* viewModels;

- (instancetype)initWithDiscoverModel:(TMSDiscoverModel *)model;
@end

NS_ASSUME_NONNULL_END
