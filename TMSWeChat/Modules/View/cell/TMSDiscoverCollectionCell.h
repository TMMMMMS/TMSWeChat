//
//  TMSDiscoverCollectionCell.h
//  TMSWeChat
//
//  Created by TmmmS on 2019/5/19.
//  Copyright © 2019年 TMS. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TMSBaseCellViewModel;

NS_ASSUME_NONNULL_BEGIN

@interface TMSDiscoverCollectionCell : UICollectionViewCell

+ (instancetype)createCellWithBaseCellViewModel:(TMSBaseCellViewModel *)baseCellViewModel;
- (void)bindViewModel:(id)viewModel;
@end

NS_ASSUME_NONNULL_END
