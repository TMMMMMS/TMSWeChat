//
//  TMSCommentCollectionCell.m
//  TMSWeChat
//
//  Created by TmmmS on 2019/5/19.
//  Copyright © 2019年 TMS. All rights reserved.
//

#import "TMSCommentCollectionCell.h"
#import "TMSCommentCollectionCellViewModel.h"

@interface TMSCommentCollectionCell ()

@property(nonatomic, strong) YYLabel *commentLabel;

@property(nonatomic, readwrite, strong) TMSCommentCollectionCellViewModel *viewModel;
@end

@implementation TMSCommentCollectionCell
- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self == [super initWithFrame:frame]) {
        self.backgroundColor = RGB(243, 242, 245, 1);
        [self configViews];
    }
    return self;
}

- (void)bindViewModel:(TMSCommentCollectionCellViewModel *)viewModel {
    
    self.viewModel = viewModel;
    
    self.commentLabel.attributedText = viewModel.commentAttributedString;
}

- (void)configViews {
    
    CGFloat leftPadding = cellPadding + 42 + cellItemInset * 2;
    self.commentLabel = [[YYLabel alloc] init];
    self.commentLabel.lineBreakMode = NSLineBreakByCharWrapping;
    self.commentLabel.textVerticalAlignment = YYTextVerticalAlignmentTop;
    self.commentLabel.numberOfLines = 0;
    self.commentLabel.preferredMaxLayoutWidth = SCREEN_WIDTH - leftPadding - cellPadding - cellItemInset;
    [self.contentView addSubview:self.commentLabel];
    [self.commentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.inset(cellItemInset);
        make.top.equalTo(@5);
    }];
}
@end
