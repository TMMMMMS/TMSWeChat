//
//  TMSContentCollectionCell.h
//  TMSWeChat
//
//  Created by TmmmS on 2019/5/19.
//  Copyright © 2019年 TMS. All rights reserved.
//

#import "TMSDiscoverCollectionCell.h"

@class TMSContentCollectionCellViewModel;

NS_ASSUME_NONNULL_BEGIN

@interface TMSContentCollectionCell : TMSDiscoverCollectionCell
@property(nonatomic, readonly, strong) TMSContentCollectionCellViewModel *viewModel;
@end

NS_ASSUME_NONNULL_END
