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
// 点击昵称
@property (nonatomic, readwrite, strong) RACSubject *didClickedNameSubject;
// 点击照片
@property (nonatomic, readwrite, strong) RACSubject *didClickedPicSubject;

@property(nonatomic, readwrite, strong) RACSubject *clickActionSubject;
// 评论
@property (nonatomic, readwrite, strong) RACSubject *didClickedCommentSubject;
@end

@implementation TMSDiscoverViewModel

- (instancetype)init {
    
    if (self == [super init]) {
        
        self.didClickedNameSubject = [RACSubject subject];
        self.didClickedPicSubject = [RACSubject subject];
        self.clickActionSubject = [RACSubject subject];
        self.didClickedCommentSubject = [RACSubject subject];
        
        // 处理网络请求后的数据，此处暂时使用本地json数据
        self.discovers = [NSMutableArray array];
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
        itemModel.didClickedNameSubject = self.didClickedNameSubject;
        itemModel.didClickedPicSubject = self.didClickedPicSubject;
        itemModel.clickActionSubject = self.clickActionSubject;
        itemModel.didClickedCommentSubject = self.didClickedCommentSubject;
        
        TMSCommentSectionViewModel *commentModel = [[TMSCommentSectionViewModel alloc] initWithDiscoverModel:model];
        [itemArray addObject:itemModel];
        [itemArray addObject:commentModel];
    }

    [self.discovers addObjectsFromArray:itemArray.copy];;
}


@end
