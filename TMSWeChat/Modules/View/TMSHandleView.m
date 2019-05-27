//
//  TMSHandleView.m
//  TMSWeChat
//
//  Created by TmmmS on 2019/5/23.
//  Copyright © 2019年 TMS. All rights reserved.
//

#import "TMSHandleView.h"
#import "TMSTimeCollectionCellViewModel.h"

static TMSHandleView *_instance = nil;

@interface TMSHandleView ()
@property(nonatomic, strong) UIButton *likeBtn;
@property(nonatomic, strong) UIButton *commentBtn;
@property(nonatomic, strong) TMSTimeCollectionCellViewModel *viewModel;
@end

@implementation TMSHandleView

- (instancetype)init {
    
    if (self == [super init]) {
        self.layer.cornerRadius = 5;
        self.layer.masksToBounds = YES;
        self.backgroundColor = RGB(243, 242, 245, 1);
        [self configViews];
    }
    return self;
}

- (void)bindViewModel:(TMSTimeCollectionCellViewModel *__nullable)viewModel {
    
    if (viewModel == self.viewModel || viewModel == nil) {
//        self.hidden = YES;
        self.viewModel = nil;
        return;
    }
    
    self.viewModel = viewModel;
    
    self.likeBtn.selected = NO;
//    self.likeBtn.selected = viewModel.discoverModel.li
}

- (void)configViews {
    
    self.likeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.likeBtn setTitle:@"点赞" forState:UIControlStateNormal];
    [self.likeBtn setTitle:@"取消" forState:UIControlStateSelected];
    [self.likeBtn setTitleColor:RGB(88, 104, 144, 1) forState:UIControlStateNormal];
    self.likeBtn.titleLabel.font = [UIFont systemFontOfSize:12 weight:UIFontWeightBold];
    [self.likeBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [[self.likeBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIButton * _Nullable x) {
        x.selected = !x.selected;
    }];
    [self addSubview:self.likeBtn];
    [self.likeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(self);
        make.width.equalTo(@45);
    }];
    
    self.commentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.commentBtn setTitle:@"评论" forState:UIControlStateNormal];
    [self.commentBtn setTitleColor:RGB(88, 104, 144, 1) forState:UIControlStateNormal];
    self.commentBtn.titleLabel.font = [UIFont systemFontOfSize:12 weight:UIFontWeightBold];
    [self.commentBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [self addSubview:self.commentBtn];
    @weakify(self)
    [[self.commentBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
       @strongify(self)
        [self.viewModel.didClickedCommentSubject sendNext:self.viewModel];
    }];
    [self.commentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.equalTo(self);
        make.width.equalTo(self.likeBtn);
    }];
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = [UIColor whiteColor];
    [self addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(1, 20));
    }];
}

+ (instancetype)shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (_instance == nil) {
            _instance = [[self alloc] init];
        }
    });
    return _instance;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}

- (id)copyWithZone:(NSZone *)zone
{
    return _instance;
}

-(id)mutableCopyWithZone:(NSZone *)zone {
    return _instance;
}

@end
