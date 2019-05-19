//
//  TMSBaseCellViewModel.h
//  TMSWeChat
//
//  Created by TmmmS on 2019/5/19.
//  Copyright © 2019年 TMS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TMSDiscoverModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TMSBaseCellViewModel : NSObject <IGListDiffable>

@property(nonatomic, readonly, strong) TMSDiscoverModel *discoverModel;
@property(nonatomic, readonly, assign) CGFloat cellHeight;

- (instancetype)initWithDiscoverModel:(TMSDiscoverModel *)model;
- (void)initializeConfig;
- (void)calculateCellHeight;
@end

NS_ASSUME_NONNULL_END
