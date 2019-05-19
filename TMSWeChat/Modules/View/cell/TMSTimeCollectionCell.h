//
//  TMSTimeCollectionCell.h
//  TMSWeChat
//
//  Created by TmmmS on 2019/5/19.
//  Copyright © 2019年 TMS. All rights reserved.
//

#import "TMSDiscoverCollectionCell.h"
@class TMSTimeCollectionCellViewModel;

NS_ASSUME_NONNULL_BEGIN

@interface TMSTimeCollectionCell : TMSDiscoverCollectionCell
@property(nonatomic, readonly, strong) TMSTimeCollectionCellViewModel *viewModel;
@end

NS_ASSUME_NONNULL_END
