//
//  TMSLikeCollectionCell.h
//  TMSWeChat
//
//  Created by TmmmS on 2019/5/19.
//  Copyright © 2019年 TMS. All rights reserved.
//

#import "TMSDiscoverCollectionCell.h"

@class TMSLikeCollectionCellViewModel;

NS_ASSUME_NONNULL_BEGIN

@interface TMSLikeCollectionCell : TMSDiscoverCollectionCell
@property(nonatomic, readonly, strong) TMSLikeCollectionCellViewModel *viewModel;
@end

NS_ASSUME_NONNULL_END
