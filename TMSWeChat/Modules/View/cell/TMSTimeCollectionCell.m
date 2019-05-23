//
//  TMSTimeCollectionCell.m
//  TMSWeChat
//
//  Created by TmmmS on 2019/5/19.
//  Copyright © 2019年 TMS. All rights reserved.
//

#import "TMSTimeCollectionCell.h"
#import "TMSTimeCollectionCellViewModel.h"

@interface TMSTimeCollectionCell ()
@property(nonatomic, strong) UILabel *dateLabel;
@property(nonatomic, strong) UIButton *actionBtn;
@property(nonatomic, readwrite, strong) TMSTimeCollectionCellViewModel *viewModel;
@end

@implementation TMSTimeCollectionCell

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self == [super initWithFrame:frame]) {
        [self configViews];
        
        @weakify(self)
        [[self.actionBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self)
            [self.viewModel.clickActionSubject sendNext:self.viewModel];
            [self.viewModel.clickActionSubject sendNext:x];
        }];
    }
    return self;
}

- (void)bindViewModel:(TMSTimeCollectionCellViewModel *)viewModel {
    
    self.viewModel = viewModel;
    
    self.dateLabel.text = [NSString stringWithFormat:@"%zd", viewModel.discoverModel.time];
}

- (void)configViews {
    
    self.dateLabel = [[UILabel alloc] init];
    self.dateLabel.font = [UIFont systemFontOfSize:14];
    self.dateLabel.textColor = RGB(173, 173, 173, 1);
    [self.contentView addSubview:self.dateLabel];
    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(42+2*cellPadding));
        make.centerY.equalTo(self.contentView);
    }];
    
    self.actionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.actionBtn.backgroundColor = [UIColor redColor];
    [self.actionBtn setTitle:@"· ·" forState:UIControlStateNormal];
    self.actionBtn.titleLabel.font = [UIFont systemFontOfSize:10 weight:UIFontWeightBold];
    [self.contentView addSubview:self.actionBtn];
    [self.actionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-cellPadding));
        make.centerY.equalTo(self.contentView);
        
    }];
}
@end
