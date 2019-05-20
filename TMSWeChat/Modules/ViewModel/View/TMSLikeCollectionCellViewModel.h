//
//  TMSLikeCollectionCellViewModel.h
//  TMSWeChat
//
//  Created by TmmmS on 2019/5/19.
//  Copyright © 2019年 TMS. All rights reserved.
//

#import "TMSBaseCellViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TMSLikeCollectionCellViewModel : TMSBaseCellViewModel
// 点赞的用户
@property (nonatomic, readonly, copy) NSAttributedString *likeUserAttributedString;
@end

NS_ASSUME_NONNULL_END
