//
//  TMSLikeCollectionCell.m
//  TMSWeChat
//
//  Created by TmmmS on 2019/5/19.
//  Copyright © 2019年 TMS. All rights reserved.
//

#import "TMSLikeCollectionCell.h"
#import "TMSLikeCollectionCellViewModel.h"

@interface TMSLikeCollectionCell ()
@property(nonatomic, strong) YYLabel *likeLabel;
@property(nonatomic, readwrite, strong) TMSLikeCollectionCellViewModel *viewModel;
@end

@implementation TMSLikeCollectionCell

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self == [super initWithFrame:frame]) {
        [self configViews];
    }
    return self;
}

- (void)bindViewModel:(TMSLikeCollectionCellViewModel *)viewModel {
    
    self.viewModel = viewModel;
    
    self.likeLabel.attributedText = viewModel.likeUserAttributedString;
}

- (void)configViews {
    
    UIView *container = [[UIView alloc] init];
    container.backgroundColor = RGB(243, 242, 245, 1);
    [self.contentView addSubview:container];
    [container mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(cellPadding + 42 + cellItemInset));
        make.top.equalTo(self.contentView);
        make.right.equalTo(@(-cellPadding));
    }];
    
    UIImageView *img = [[UIImageView alloc] init];
    img.image = TMSImageNamed(@"heart");
    [container addSubview:img];
    [img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(cellItemInset));
        make.top.equalTo(@7);
        make.size.mas_equalTo(CGSizeMake(12, 12));
    }];
    
    CGFloat leftPadding = cellPadding + 42 + cellItemInset * 4 + 12;
    self.likeLabel = [[YYLabel alloc] init];
    self.likeLabel.textVerticalAlignment = YYTextVerticalAlignmentTop;
    self.likeLabel.attributedText = self.viewModel.likeUserAttributedString;
    self.likeLabel.numberOfLines = 0;
    self.likeLabel.preferredMaxLayoutWidth = SCREEN_WIDTH - leftPadding - cellPadding - cellItemInset;
    [container addSubview:self.likeLabel];
    [self.likeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(img.mas_right).offset(cellItemInset);
        make.right.equalTo(@(-cellPadding));
        make.top.equalTo(@4);
        
        make.bottom.equalTo(container).offset(-6);
    }];
    
//    UIView *line = [[UIView alloc] init];
//    line.backgroundColor = RGB(211, 211, 213, 1);
//    [container addSubview:line];
//    [line mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.bottom.equalTo(container);
//        make.height.equalTo(@0.5);
//    }];
}

@end
