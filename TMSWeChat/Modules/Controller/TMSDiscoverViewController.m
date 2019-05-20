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
#import "TMSDiscoverSectionViewModel.h"

@interface TMSDiscoverViewController ()<IGListAdapterDataSource>
@property(nonatomic, strong) TMSDiscoverViewModel *viewModel;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) IGListAdapter *adapter;
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
    self.adapter.collectionView = self.collectionView;
    self.adapter.dataSource = self;
}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    self.collectionView.frame = CGRectMake(0, [UIApplication sharedApplication].statusBarFrame.size.height+44, SCREEN_WIDTH, SCREEN_HEIGHT - [UIApplication sharedApplication].statusBarFrame.size.height);
}

- (NSArray<id <IGListDiffable>> *)objectsForListAdapter:(IGListAdapter *)listAdapter {
    return self.viewModel.discovers;
}

- (IGListSectionController *)listAdapter:(IGListAdapter *)listAdapter sectionControllerForObject:(id)object {
    
//    return [object isKindOfClass:[TMSDiscoverSectionViewModel class]] ? [TMSDiscoverSectionController new] : [TMSCommentSectionController new];
    
    IGListSectionController *vc = nil;
    if ([object isKindOfClass:[TMSDiscoverSectionViewModel class]]) {
        vc = [TMSDiscoverSectionController new];
    } else {
        vc = [TMSCommentSectionController new];
        vc.inset = UIEdgeInsetsMake(-2, cellPadding+42+cellItemInset, 0, cellPadding);
    }
    return vc;
//    return [TMSCommentSectionController new];
}

- (nullable UIView *)emptyViewForListAdapter:(IGListAdapter *)listAdapter {
    
    UIView *temp = [[UIView alloc] initWithFrame:CGRectMake(0, 100, SCREEN_WIDTH, 90)];
    temp.backgroundColor = [UIColor redColor];
    return temp;
}

- (IGListAdapter *)adapter {
    if (!_adapter) {
        _adapter = [[IGListAdapter alloc] initWithUpdater:[IGListAdapterUpdater new] viewController:self];
    }
    
    return _adapter;
}

- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *flow = [UICollectionViewFlowLayout new];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flow];
        _collectionView.backgroundColor = [UIColor whiteColor];
    }
    return _collectionView;
}
@end
