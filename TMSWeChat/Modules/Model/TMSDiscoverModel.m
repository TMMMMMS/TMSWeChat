//
//  TMSDiscoverModel.m
//  TMSWeChat
//
//  Created by TmmmS on 2019/5/19.
//  Copyright © 2019年 TMS. All rights reserved.
//

#import "TMSDiscoverModel.h"
#import <CommonCrypto/CommonRandom.h>

@implementation TMSDiscoverModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    
    return @{@"ID": @"id"};
}

+ (NSDictionary *)mj_objectClassInArray
{
    return @{
             @"comments":@"TMSCommentModel"
             };
}

//- (NSInteger)pic_num {
//    
////    int x = 0;
////    do {
////        x = arc4random() % 10;
////    } while (self.summary.length != 0 && x != 0);
////    
////    return x;
//////    return 1;
//}

- (NSString *)like_user {
    
    if (_like_user.length == 0) {
        NSMutableArray *userArray = [NSMutableArray array];
        for (NSInteger i = 0; i < self.likes_num; i++) {
            [userArray addObject:[self randomNoNumber:(arc4random() % 6 + 2)]];
        }
        _like_user = [userArray componentsJoinedByString:@"，"];
    }
    return _like_user;
}

// 生成点赞的用户名
- (NSString *)randomNoNumber: (int)len {
    
    char ch[len];
    for (int index=0; index<len; index++) {
        
        int num = arc4random_uniform(58)+65;
        if (num>90 && num<97) { num = num%90+65; }
        ch[index] = num;
    }
    
    return [[NSString alloc] initWithBytes:ch length:len encoding:NSUTF8StringEncoding];
}

//- (NSInteger)numOfSection {
//    
//    // 初始值设为2：内容section + 时间section
//    int num = 2;
//    
//    if (self.likes_num > 0) {
//        num++;
//    }
//    
////    if (self.comment_num > 0) {
////        num++;
////    }
//    
//    return num;
//}

- (nonnull id<NSObject>)diffIdentifier {
    return self.ID;
}

- (BOOL)isEqualToDiffableObject:(nullable id<IGListDiffable>)object {
    
    if (object == self) {
        return YES;
    }
    TMSDiscoverModel *obj = (TMSDiscoverModel *)object;
    return [self.ID isEqualToString:obj.ID];
        
}
@end
