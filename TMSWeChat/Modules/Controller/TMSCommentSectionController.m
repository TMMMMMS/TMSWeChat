//
//  TMSCommentSectionController.m
//  TMSWeChat
//
//  Created by TmmmS on 2019/5/20.
//  Copyright © 2019年 TMS. All rights reserved.
//

#import "TMSCommentSectionController.h"
#import "TMSCommentSectionViewModel.h"
#import "TMSCommentCollectionCellViewModel.h"
#import "TMSCommentCollectionCell.h"

@interface TMSCommentSectionController ()
@property(nonatomic, strong) TMSCommentSectionViewModel *viewModel;

@end

@implementation TMSCommentSectionController

- (instancetype)init {
    
    if (self == [super init]) {
        
        [[[NSNotificationCenter defaultCenter] rac_addObserverForName:@"RefreshDatas" object:nil] subscribeNext:^(NSNotification * _Nullable x) {
           
            TMSCommentSectionViewModel *model = x.object;
            if (model == self.viewModel) {
//                TLog(@"需要刷新评论");
                [self.collectionContext performBatchAnimated:YES updates:^(id<IGListBatchContext>  _Nonnull batchContext) {
                    NSIndexSet *set = [NSIndexSet indexSetWithIndex:self.viewModel.comment_num - 1];
                    [batchContext insertInSectionController:self atIndexes:set];
                } completion:^(BOOL finished) {
                    
                }];
                
            }
        }];
        
    }
    return self;
}

- (NSInteger)numberOfItems {
    
    return self.viewModel.comment_num;
    
}

- (CGSize)sizeForItemAtIndex:(NSInteger)index {
    
    TMSCommentCollectionCellViewModel *viewModel = self.viewModel.viewModels[index];
    
    return CGSizeMake(SCREEN_WIDTH - 2*cellPadding - 42 - cellItemInset, self.viewModel.comment_num ? viewModel.cellHeight : 0);
}

- (UICollectionViewCell *)cellForItemAtIndex:(NSInteger)index {
    
    TMSCommentCollectionCellViewModel *viewModel = self.viewModel.viewModels[index];
    
    TMSCommentCollectionCell *cell = [self.collectionContext dequeueReusableCellOfClass:[TMSCommentCollectionCell class] forSectionController:self atIndex:index];
    
    [cell bindViewModel:viewModel isShowLine:(self.viewModel.discoverModel.likes_num && index == 0)];
    
    return cell;
}

- (void)didUpdateToObject:(id)object {
    
    self.viewModel = object;
}

- (void)didSelectItemAtIndex:(NSInteger)index {
    
    TLog(@"点击了评论");
}

@end
