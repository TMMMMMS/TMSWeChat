//
//  TMSContentCellViewModel.h
//  TMSWeChat
//
//  Created by TmmmS on 2019/5/19.
//  Copyright © 2019年 TMS. All rights reserved.
//

#import "TMSBaseCellViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TMSContentCollectionCellViewModel : TMSBaseCellViewModel

@property(nonatomic, readonly, assign) CGFloat picHeight;

// 点击昵称
@property (nonatomic, readwrite, strong) RACSubject *didClickedNameSubject;
// 点击照片
@property (nonatomic, readwrite, strong) RACSubject *didClickedPicSubject;

@end

NS_ASSUME_NONNULL_END
