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
#import "TMSHandleView.h"
@interface TMSDiscoverSectionController ()
@property(nonatomic, strong) TMSDiscoverSectionViewModel *viewModel;
@property(nonatomic, strong) TMSHandleView *handleView;
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
    
    @weakify(self)
    [self.viewModel.clickActionSubject subscribeNext:^(id  _Nullable x) {
        
        @strongify(self)
//        TLog(@"点击了按钮:%@", x);
        TMSBaseCellViewModel *tempModel = nil;
        if ([x isKindOfClass:[TMSBaseCellViewModel class]]) {
            tempModel = x;
            [self.handleView bindViewModel:x];
        }
        if ([x isKindOfClass:[UIButton class]]) { // 将cell上button的坐标系转换成view的坐标系
            UIButton *btn = (UIButton *)x;
            self.handleView.hidden = !self.handleView.viewModel;
            CGPoint btnPointInView = [btn.superview convertPoint:btn.frame.origin toView:nil];
//            TLog(@"btnPointInView:%@", NSStringFromCGPoint(btnPointInView));
            if (self.handleView.viewModel) {
                CGRect handleRect = self.handleView.frame;
                handleRect.origin.y = btnPointInView.y;
                self.handleView.frame = handleRect;
                [UIView animateWithDuration:0.5 animations:^{
                    self.handleView.alpha = 1;
                }];
            } else {
                [UIView animateWithDuration:0.5 animations:^{
                    self.handleView.alpha = 0;
                }];
            }
        }
    }];
    [self.viewModel.didClickedNameSubject subscribeNext:^(id  _Nullable x) {
        TLog(@"点击了昵称");
    }];
    [self.viewModel.didClickedCommentSubject subscribeNext:^(id  _Nullable x) {
        TLog(@"点击评论了");
        @strongify(self)
        self.handleView.hidden = YES;
    }];
}

- (void)didSelectItemAtIndex:(NSInteger)index {
    
}

- (TMSHandleView *)handleView{
    
    if (!_handleView) {
        _handleView = [TMSHandleView shareInstance];
        _handleView.frame = CGRectMake(SCREEN_WIDTH - 90 - cellPadding - 30, 90, 90, 23);
        _handleView.alpha = 0;
        [self.viewController.view addSubview:_handleView];
    }
    return _handleView;
}

@end
