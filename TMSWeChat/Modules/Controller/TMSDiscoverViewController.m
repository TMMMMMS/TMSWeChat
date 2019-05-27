//
//  TMSDiscoverViewController.m
//  TMSWeChat
//
//  Created by TmmmS on 2019/5/19.
//  Copyright © 2019年 TMS. All rights reserved.
//

#import "TMSDiscoverViewController.h"
#import "TMSDiscoverSectionController.h"
#import "TMSCommentSectionController.h"
#import "TMSDiscoverViewModel.h"
#import "TMSBaseCellViewModel.h"
#import "TMSDiscoverSectionViewModel.h"
#import "TMSCommentSectionViewModel.h"
#import "TMSHandleView.h"
#import "TMSInputView.h"
#import "TMSCommentModel.h"

@interface TMSDiscoverViewController ()<IGListAdapterDataSource, UIScrollViewDelegate>

@property(nonatomic, strong) TMSDiscoverViewModel *viewModel; // vc的viewModel
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, readwrite, strong) IGListAdapter *adapter;

@property(nonatomic, strong) TMSHandleView *handleView;
@property(nonatomic, strong) TMSInputView *inputView;

/* 记录点击的是哪个sectionController的model，用于添加评论使用 */
@property(nonatomic, strong) TMSBaseCellViewModel *handleModel;
@end

@implementation TMSDiscoverViewController

- (instancetype)initWtihViewModel:(TMSDiscoverViewModel *)viewModel {
    
    if (self == [super init]) {
        self.viewModel = viewModel;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"Discover";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(@([UIApplication sharedApplication].statusBarFrame.size.height+44));
    }];
    self.adapter.collectionView = self.collectionView;
    self.adapter.dataSource = self;
    
    [self.view addSubview:self.handleView];
    [self.view addSubview:self.inputView];
    
    @weakify(self)
    [self.viewModel.didClickedNameSubject subscribeNext:^(id  _Nullable x) {
        TLog(@"点击了昵称：%@", x);
        @strongify(self)
        [self scrollViewDidScroll:self.collectionView];
    }];
    
    [self.viewModel.didClickedPicSubject subscribeNext:^(id  _Nullable x) {
        TLog(@"点击了照片");
    }];
    
    [self.viewModel.clickActionSubject subscribeNext:^(id  _Nullable x) {
        
        @strongify(self)
        TMSTimeCollectionCellViewModel *model = (TMSTimeCollectionCellViewModel *)[x objectForKey:@"model"];
        UIButton *button = [x objectForKey:@"button"];

        //        TLog(@"点击了按钮:%@", x);
        if (model) {
            [self.handleView bindViewModel:model];
        }
        if (button) { // 将cell上button的坐标系转换成view的坐标系
            //            UIButton *btn = (UIButton *)x;
            self.handleView.hidden = !self.handleView.viewModel;

            if (self.handleView.viewModel) {

                CGPoint btnPointInView = [button.superview convertPoint:button.frame.origin toView:nil];
                //            TLog(@"btnPointInView:%@", NSStringFromCGPoint(btnPointInView));

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
    
    [self.viewModel.didClickedCommentSubject subscribeNext:^(id  _Nullable x) {
        
        TLog(@"点击评论了，调起输入框");
        
        if ([x isMemberOfClass:[TMSBaseCellViewModel class]]) {
            TLog(@"接收类型出错");
            return ;
        }
        
        @strongify(self)
        self.handleModel = x;
        self.handleView.hidden = YES;
        
        self.inputView.hidden = NO;
        [self.inputView.textField becomeFirstResponder];
    }];
    
    [self.inputView.textFieldSubject subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        if (self.handleModel) {
            [self.viewModel.discovers enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                if ([obj isKindOfClass:[TMSCommentSectionViewModel class]]) {
                    
                    TMSCommentSectionViewModel *model = (TMSCommentSectionViewModel *)obj;
                    
                    if ([model.discoverModel.ID isEqualToString:self.handleModel.discoverModel.ID]) {
                        
//                        TLog(@"添加了一条评论");
                        [model addCommentModel:[[TMSCommentModel alloc] initComment:x]];
                        [[NSNotificationCenter defaultCenter] postNotificationName:@"RefreshDatas" object:model];
                        *stop = YES;
                    }
                }
            }];
        }
    }];
}


- (NSArray<id <IGListDiffable>> *)objectsForListAdapter:(IGListAdapter *)listAdapter {
    return self.viewModel.discovers;
}

- (IGListSectionController *)listAdapter:(IGListAdapter *)listAdapter sectionControllerForObject:(id)object {
    
    IGListSectionController *vc = nil;
    if ([object isKindOfClass:[TMSDiscoverSectionViewModel class]]) {
        vc = [TMSDiscoverSectionController new];
    } else {
        vc = [TMSCommentSectionController new];
        vc.inset = UIEdgeInsetsMake(-2, cellPadding+42+cellItemInset, 0, cellPadding);
    }
    return vc;
}

- (nullable UIView *)emptyViewForListAdapter:(IGListAdapter *)listAdapter {
    
    UIView *temp = [[UIView alloc] initWithFrame:CGRectMake(0, 100, SCREEN_WIDTH, 90)];
    temp.backgroundColor = [UIColor redColor];
    return temp;
}

#pragma mark - scrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (!self.handleView.hidden) {
        [self.handleView bindViewModel:nil];
        self.handleView.alpha = 0;
    }
    
    if (!self.inputView.hidden) {
        self.inputView.textField.text = nil;
        [self.inputView.textField resignFirstResponder];
    }
}

#pragma mark - Lazying loading
- (IGListAdapter *)adapter {
    if (!_adapter) {
        _adapter = [[IGListAdapter alloc] initWithUpdater:[IGListAdapterUpdater new] viewController:self];
        _adapter.scrollViewDelegate = self;
    }
    
    return _adapter;
}

- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *flow = [UICollectionViewFlowLayout new];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flow];
        _collectionView.backgroundColor = [UIColor whiteColor];
        if (@available(iOS 11.0, *)) {
            _collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
    }
    return _collectionView;
}


- (TMSHandleView *)handleView{
    
    if (!_handleView) {
        _handleView = [TMSHandleView shareInstance];
        _handleView.frame = CGRectMake(SCREEN_WIDTH - 90 - cellPadding - 30, 90, 90, 23);
        _handleView.alpha = 0;
    }
    return _handleView;
}

- (TMSInputView *)inputView{
    
    if (!_inputView) {
        _inputView = [TMSInputView shareInstance];
        _inputView.frame = CGRectMake(0, SCREEN_HEIGHT - 35, SCREEN_WIDTH, 35);
        _inputView.hidden = YES;
    }
    return _inputView;
}
@end
