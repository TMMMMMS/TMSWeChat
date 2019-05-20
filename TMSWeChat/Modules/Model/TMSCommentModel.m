//
//  TMSCommentModel.m
//  TMSWeChat
//
//  Created by TmmmS on 2019/5/20.
//  Copyright © 2019年 TMS. All rights reserved.
//

#import "TMSCommentModel.h"

@interface TMSCommentModel ()
@property(nonatomic, readwrite, copy) NSString *showComment;
@end

@implementation TMSCommentModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    
    return @{@"ID": @"id"};
}

- (NSString *)showComment{
    
    if (!_showComment) {
        _showComment = @"AAAA";
        NSMutableString *str = [[NSMutableString alloc] initWithString:self.from];
        if (self.to.length) {
            [str appendString:[NSString stringWithFormat:@" @ %@", self.to]];
        }
        [str appendString:[NSString stringWithFormat:@":%@", self.comment]];
        
        _showComment = str.copy;
    }
    return _showComment;
}

- (nonnull id<NSObject>)diffIdentifier {
    return self.ID;
}

- (BOOL)isEqualToDiffableObject:(nullable id<IGListDiffable>)object {

    if (object == self) {
        return YES;
    }
    TMSCommentModel *obj = (TMSCommentModel *)object;
    return [self.ID isEqualToString:obj.ID];

}

@end

