//
//  TMSDiscoverModel.h
//  TMSWeChat
//
//  Created by TmmmS on 2019/5/19.
//  Copyright © 2019年 TMS. All rights reserved.
//

#import <Foundation/Foundation.h>
@class TMSCommentModel;

NS_ASSUME_NONNULL_BEGIN

@interface TMSDiscoverModel : NSObject <IGListDiffable>
@property(nonatomic, copy) NSString *ID;
@property(nonatomic, copy) NSString *summary;
@property(nonatomic, copy) NSString *author_name;
@property(nonatomic, assign) NSInteger time;
@property(nonatomic, assign) NSInteger comment_num;
@property(nonatomic, assign) NSInteger pic_num;
@property(nonatomic, assign) NSInteger likes_num;
@property(nonatomic, strong) NSArray <TMSCommentModel *> *comments;

#pragma mark - support property
// 分区个数，TMSDiscoverSectionController中使用
//@property(nonatomic, assign) NSInteger numOfSection;
// 点赞的用户
@property(nonatomic, copy) NSString *like_user;
@end

NS_ASSUME_NONNULL_END
