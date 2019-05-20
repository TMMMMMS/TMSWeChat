//
//  TMSDiscoverSectionController.m
//  TMSWeChat
//
//  Created by TmmmS on 2019/5/19.
//  Copyright © 2019年 TMS. All rights reserved.
//

#import "TMSDiscoverSectionController.h"
#import "TMSDiscoverSectionViewModel.h"
#import "TMSDiscoverCollectionCell.h"
#import "TMSBaseCellViewModel.h"

@interface TMSDiscoverSectionController ()
@property(nonatomic, strong) TMSDiscoverSectionViewModel *viewModel;
@end

@implementation TMSDiscoverSectionController

- (NSInteger)numberOfItems {
    
    return self.viewModel.cellViewModels.count;
}

- (CGSize)sizeForItemAtIndex:(NSInteger)index {
    
    TMSBaseCellViewModel *viewModel = self.viewModel.cellViewModels[index];
    
    return CGSizeMake(self.collectionContext.containerSize.width, viewModel.cellHeight);
}

- (UICollectionViewCell *)cellForItemAtIndex:(NSInteger)index {
    
    id obj = self.viewModel.cellViewModels[index];
    
    NSString *objClass = NSStringFromClass([obj class]);
    TMSDiscoverCollectionCell *cell = [self.collectionContext dequeueReusableCellOfClass:NSClassFromString([objClass stringByReplacingOccurrencesOfString:@"ViewModel" withString:@""]) forSectionController:self atIndex:index];
    
    [cell bindViewModel:obj];
    
    return cell;
}

- (void)didUpdateToObject:(id)object {
    self.viewModel = object;
    
    [self.viewModel.didClickedNameSubject subscribeNext:^(id  _Nullable x) {
        TLog(@"点击了昵称");
    }];
    [self.viewModel.didClickedCommentSubject subscribeNext:^(id  _Nullable x) {
        TLog(@"点击评论了");
    }];
}

- (void)didSelectItemAtIndex:(NSInteger)index {
    
}

@end
