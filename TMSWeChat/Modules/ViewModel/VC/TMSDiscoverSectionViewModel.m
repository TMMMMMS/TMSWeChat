//
//  TMSDiscoverSectionViewModel.m
//  TMSWeChat
//
//  Created by TmmmS on 2019/5/19.
//  Copyright © 2019年 TMS. All rights reserved.
//

#import "TMSDiscoverSectionViewModel.h"
#import "TMSDiscoverModel.h"
#import "TMSContentCollectionCellViewModel.h"
#import "TMSTimeCollectionCellViewModel.h"
#import "TMSLikeCollectionCellViewModel.h"
#import "TMSCommentCollectionCellViewModel.h"

@interface TMSDiscoverSectionViewModel ()
@property(nonatomic, strong) TMSDiscoverModel *discoverModel;
@property(nonatomic, readwrite, strong) NSArray <TMSBaseCellViewModel *>* cellViewModels;
@property(nonatomic, readwrite, assign) CGFloat cellHeight;

/// ContentCell上的事件
// 点赞
@property (nonatomic, readwrite, strong) RACCommand *likeCommand;
@end

@implementation TMSDiscoverSectionViewModel
- (instancetype)initWithDiscoverModel:(TMSDiscoverModel *)model {
    
    if (self == [super init]) {
        self.discoverModel = model;

        self.addCommentSubject = [RACSubject subject];
        
        NSMutableArray *cellModelsArray = [NSMutableArray array];
        
        /// 创建cell上的各个viewModel
        TMSContentCollectionCellViewModel *contentModel = [[TMSContentCollectionCellViewModel alloc] initWithDiscoverModel:model];
        contentModel.didClickedPicSubject = self.didClickedPicSubject;
        [cellModelsArray addObject:contentModel];
        
        // 时间section的viewModel
        TMSTimeCollectionCellViewModel *timeModel = [[TMSTimeCollectionCellViewModel alloc] initWithDiscoverModel:model];
        timeModel.likeCommand = self.likeCommand;
        timeModel.addCommentSubject = self.addCommentSubject;
        [cellModelsArray addObject:timeModel];
        
        // 点赞section的viewModel
        if (self.discoverModel.likes_num) {
            TMSLikeCollectionCellViewModel *likeModel = [[TMSLikeCollectionCellViewModel alloc] initWithDiscoverModel:model];
            [cellModelsArray addObject:likeModel];
        }
        
        self.cellViewModels = cellModelsArray.copy;
        
//        /// 点赞
//        self.likeCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(SUGoodsItemViewModel * itemViewModel) {
//            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
//                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                    //                /// data
//                    //                SUGoods *goods = itemViewModel.goods;
//                    //                /// update data
//                    //                goods.isLike = !goods.isLike;
//                    //                NSInteger likes = (goods.isLike)?(goods.likes.integerValue+1):(goods.likes.integerValue-1);
//                    //                goods.likes = [NSString stringWithFormat:@"%zd",likes];
//                    [subscriber sendNext:nil];
//                    [subscriber sendCompleted];
//                });
//                return nil;
//            }];
//        }];
    }
    return self;
}

- (void)setDidClickedNameSubject:(RACSubject *)didClickedNameSubject {
    
    _didClickedNameSubject = didClickedNameSubject;
    
    TMSContentCollectionCellViewModel *model = (TMSContentCollectionCellViewModel *)[self.cellViewModels objectAtIndex:0];
    model.didClickedNameSubject = didClickedNameSubject;
}

- (void)setDidClickedPicSubject:(RACSubject *)didClickedPicSubject {
    
    _didClickedPicSubject = didClickedPicSubject;
    
    TMSContentCollectionCellViewModel *model = (TMSContentCollectionCellViewModel *)[self.cellViewModels objectAtIndex:0];
    model.didClickedPicSubject = didClickedPicSubject;
}

- (void)setClickActionSubject:(RACSubject *)clickActionSubject {
    
    _clickActionSubject = clickActionSubject;
    
    TMSTimeCollectionCellViewModel *model = (TMSTimeCollectionCellViewModel *)[self.cellViewModels objectAtIndex:1];
    model.clickActionSubject = clickActionSubject;
}

- (void)setDidClickedCommentSubject:(RACSubject *)didClickedCommentSubject {
    
    _didClickedCommentSubject = didClickedCommentSubject;
    TMSTimeCollectionCellViewModel *model = (TMSTimeCollectionCellViewModel *)[self.cellViewModels objectAtIndex:1];
    model.didClickedCommentSubject = didClickedCommentSubject;
}

- (nonnull id<NSObject>)diffIdentifier {
    return self.discoverModel.ID;
}

- (BOOL)isEqualToDiffableObject:(nullable id<IGListDiffable>)object {
    
    if (object == self) {
        return YES;
    }
    TMSDiscoverSectionViewModel *obj = (TMSDiscoverSectionViewModel *)object;
    return [self.discoverModel.ID isEqualToString:obj.discoverModel.ID];
    
}
@end
