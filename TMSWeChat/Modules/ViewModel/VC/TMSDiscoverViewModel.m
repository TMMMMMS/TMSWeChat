//
//  TMSDiscoverViewModel.m
//  TMSWeChat
//
//  Created by TmmmS on 2019/5/19.
//  Copyright © 2019年 TMS. All rights reserved.
//

#import "TMSDiscoverViewModel.h"
#import "TMSDiscoverSectionViewModel.h"
#import "TMSCommentSectionViewModel.h"
#import "TMSDiscoverModel.h"

@interface TMSDiscoverViewModel ()
@property(nonatomic, strong) NSArray *discovers;
@end

@implementation TMSDiscoverViewModel

- (instancetype)init {
    
    if (self == [super init]) {
        // 处理网络请求后的数据，此处暂时使用本地json数据
        [self asyncRemoteDatas];
    }
    return self;
}

- (void)asyncRemoteDatas {
    
    NSData *JSONData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"testdatas" ofType:@"json"]];
    
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingAllowFragments error:nil];
    
    NSArray *temp = dic[@"data"][@"list"];
    temp = [TMSDiscoverModel mj_objectArrayWithKeyValuesArray:temp];
    
    NSMutableArray *itemArray = [NSMutableArray array];
    for (TMSDiscoverModel *model in temp) {
        TMSDiscoverSectionViewModel *itemModel = [[TMSDiscoverSectionViewModel alloc] initWithDiscoverModel:model];
        TMSCommentSectionViewModel *commentModel = [[TMSCommentSectionViewModel alloc] initWithDiscoverModel:model];
        [itemArray addObject:itemModel];
        [itemArray addObject:commentModel];
    }
    
//    NSArray *itemArray = [temp.rac_sequence map:^TMSDiscoverSectionViewModel *(TMSDiscoverModel *model) {
//
//        TMSDiscoverSectionViewModel *itemModel = [[TMSDiscoverSectionViewModel alloc] initWithDiscoverModel:model];
//        return itemModel;
//    }].array;

    self.discovers = itemArray.copy;
}


@end
