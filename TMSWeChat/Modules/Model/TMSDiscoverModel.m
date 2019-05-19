//
//  TMSDiscoverModel.m
//  TMSWeChat
//
//  Created by TmmmS on 2019/5/19.
//  Copyright © 2019年 TMS. All rights reserved.
//

#import "TMSDiscoverModel.h"

@implementation TMSDiscoverModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    
    return @{@"ID": @"id"};
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

- (NSInteger)likes_num {
    
    return arc4random() % 10;
}

- (NSInteger)numOfSection {
    
    // 初始值设为2：内容section + 时间section
    int num = 2;
    
    if (self.likes_num > 0) {
        num++;
    }
    
    if (self.comment_num > 0) {
        num++;
    }
    
    return num;
}

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
