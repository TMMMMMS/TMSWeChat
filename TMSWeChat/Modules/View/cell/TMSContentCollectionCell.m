//
//  TMSContentCollectionCell.m
//  TMSWeChat
//
//  Created by TmmmS on 2019/5/19.
//  Copyright © 2019年 TMS. All rights reserved.
//

#import "TMSContentCollectionCell.h"
#import "TMSContentCollectionCellViewModel.h"
#import "TMSPicView.h"

@interface TMSContentCollectionCell ()
@property(nonatomic, strong) UIImageView *avatar;
@property(nonatomic, strong) UILabel *nameLabel;
@property(nonatomic, strong) UILabel *contentLabel;
@property(nonatomic, strong) TMSPicView *picView;

@property(nonatomic, readwrite, strong) TMSContentCollectionCellViewModel *viewModel;
@end

@implementation TMSContentCollectionCell

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self == [super initWithFrame:frame]) {
        [self configViews];
    }
    return self;
}

- (void)bindViewModel:(TMSContentCollectionCellViewModel *)viewModel {
    
    self.viewModel = viewModel;
    self.nameLabel.text = viewModel.discoverModel.author_name;
    self.contentLabel.text = viewModel.discoverModel.summary;
    self.picView.hidden = !viewModel.discoverModel.pic_num;
    
    if (viewModel.discoverModel.pic_num) {
        
        [self.picView bindViewModel:viewModel];
        if (viewModel.discoverModel.summary.length) {
            
            [self.picView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.contentLabel.mas_bottom).offset(cellItemInset);
                make.height.equalTo(@(viewModel.picHeight));
            }];
        } else {
            
            [self.picView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.contentLabel.mas_bottom).offset(0);
                make.height.equalTo(@(viewModel.picHeight));
            }];
        }
        
    }
}

- (void)configViews {
    
    self.avatar = [[UIImageView alloc] init];
//    avatar.image = TMSImageNamed(@"");
    self.avatar.backgroundColor = [UIColor blueColor];
    self.avatar.layer.cornerRadius = 5;
    self.avatar.layer.masksToBounds = YES;
    [self.contentView addSubview:self.avatar];
    [self.avatar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(42, 42));
        make.left.equalTo(@(cellPadding));
        make.top.equalTo(@(cellItemInset));
    }];
    
    self.nameLabel = [[UILabel alloc] init];
    self.nameLabel.font = [UIFont systemFontOfSize:13 weight:UIFontWeightHeavy];
    self.nameLabel.textColor = RGB(90, 106, 144, 1);
    [self.contentView addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.avatar);
        make.left.equalTo(self.avatar.mas_right).offset(cellPadding);
    }];
    
    self.contentLabel = [[UILabel alloc] init];
    self.contentLabel.numberOfLines = 0;
    self.contentLabel.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:self.contentLabel];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameLabel.mas_bottom).offset(cellItemInset);
        make.left.equalTo(self.nameLabel);
        make.right.equalTo(@(-cellPadding));
    }];
    
    self.picView = [[TMSPicView alloc] init];
    self.picView.hidden = YES;
    self.picView.backgroundColor = [UIColor blackColor];
    [self.contentView addSubview:self.picView];
    [self.picView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.nameLabel);
//        make.right.equalTo(@(-cellPadding));
//        make.top.equalTo(self.nameLabel.mas_bottom).offset(cellItemInset);
        make.left.equalTo(self.nameLabel);
        make.right.equalTo(@(-cellPadding));
        make.top.equalTo(self.contentLabel.mas_bottom).offset(cellItemInset);
        make.height.equalTo(@0);
    }];
}


@end
