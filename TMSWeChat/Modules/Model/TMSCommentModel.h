//
//  TMSCommentModel.h
//  TMSWeChat
//
//  Created by TmmmS on 2019/5/20.
//  Copyright © 2019年 TMS. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TMSCommentModel : NSObject <IGListDiffable>
@property(nonatomic, copy) NSString *ID;
@property(nonatomic, copy) NSString *from;
@property(nonatomic, copy) NSString *to;
@property(nonatomic, copy) NSString *comment;

#pragma mark Support Property
// 展示到cell上的文字，用于富文本的处理
@property(nonatomic, readonly, copy) NSString *showComment;
@end

NS_ASSUME_NONNULL_END
