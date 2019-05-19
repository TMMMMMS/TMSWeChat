//
//  TMSPicView.m
//  TMSWeChat
//
//  Created by TmmmS on 2019/5/19.
//  Copyright © 2019年 TMS. All rights reserved.
//

#import "TMSPicView.h"
#import "TMSContentCollectionCellViewModel.h"

@interface TMSPicView ()
@property(nonatomic, strong) TMSContentCollectionCellViewModel *viewModel;
@property(nonatomic, strong) UIView *singalView; // 只有一张图
@property(nonatomic, strong) UIView *doubleView; // 2张 or 4张图
@property(nonatomic, strong) UIView *normalTypeView; // 其它
@end

@implementation TMSPicView

- (instancetype)init {
    
    if (self == [super init]) {
        [self configViews];
    }
    return self;
}

- (void)configViews {
    
    [self addSubview:self.singalView];
    [self.singalView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(80, 180));
    }];
    
    [self addSubview:self.doubleView];
    [self.doubleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self);
        make.width.equalTo(@(2*90+cellPicInset));
        make.height.equalTo(@0);
    }];
    
    [self addSubview:self.normalTypeView];
    [self.normalTypeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self);
        make.width.equalTo(@(3*60 + 2*cellPicInset));
        make.height.equalTo(@0);
    }];
}

- (void)bindViewModel:(TMSContentCollectionCellViewModel *)viewModel {
    
    self.viewModel = viewModel;
    [self setupPicView];
}

- (void)setupPicView {
    
    if (self.viewModel.discoverModel.pic_num == 1) {
        
        self.singalView.hidden = NO;
        self.doubleView.hidden = YES;
        self.normalTypeView.hidden = YES;
        
        [self.singalView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(self);
            make.size.mas_equalTo(CGSizeMake(80, 180));
        }];
        
    } else if (self.viewModel.discoverModel.pic_num == 2 ||  self.viewModel.discoverModel.pic_num == 4) {
        
        self.singalView.hidden = YES;
        self.doubleView.hidden = NO;
        self.normalTypeView.hidden = YES;
        
        [self.doubleView.subviews makeObjectsPerformSelector:@selector(setImage:) withObject:nil];
        [self.doubleView.subviews enumerateObjectsUsingBlock:^(__kindof UIImageView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (idx < self.viewModel.discoverModel.pic_num) {
                obj.image = TMSImageNamed(@"cat");
            } else {
                *stop = YES;
            }
        }];
        
        NSInteger row = self.viewModel.discoverModel.pic_num / 2;
        CGFloat h = row*90 + (row - 1) * cellPicInset;
        
        [self.doubleView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(self);
            make.width.equalTo(@(2*90+cellPicInset));
            make.height.equalTo(@(h));
        }];
        
    } else {
        
        self.singalView.hidden = YES;
        self.doubleView.hidden = YES;
        self.normalTypeView.hidden = NO;
        
        [self.normalTypeView.subviews makeObjectsPerformSelector:@selector(setImage:) withObject:nil];
        [self.normalTypeView.subviews enumerateObjectsUsingBlock:^(__kindof UIImageView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (idx < self.viewModel.discoverModel.pic_num) {
                obj.image = TMSImageNamed(@"cat");
            } else {
                *stop = YES;
            }
        }];
        
        NSInteger row = self.viewModel.discoverModel.pic_num % 3 == 0 ? self.viewModel.discoverModel.pic_num / 3 : (self.viewModel.discoverModel.pic_num / 3 + 1);
        CGFloat h = row * 60 + (row - 1) * cellPicInset;
        [self.normalTypeView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(self);
            make.width.equalTo(@(row*60 + (row-1)*cellPicInset));
            make.height.equalTo(@(h));
        }];
    }
}

- (UIView *)singalView{
    
    if (!_singalView) {
        _singalView = [[UIView alloc] init];
        _singalView.hidden = YES;
        
        UIImageView *img = [[UIImageView alloc] init];
        img.contentMode = UIViewContentModeScaleAspectFit;
        [_singalView addSubview:img];
        [img mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(self.singalView);
            make.height.equalTo(@180);
        }];
    }
    return _singalView;
}

- (UIView *)doubleView{
    
    if (!_doubleView) {
        _doubleView = [[UIView alloc] init];
        _doubleView.hidden = YES;
        
        UIImageView *lastImg = nil;
        CGFloat picW = 90;
        for (NSInteger i = 0; i < 4; i++) {
            
            UIImageView *img = [[UIImageView alloc] init];
            img.contentMode = UIViewContentModeScaleAspectFill;
            [_doubleView addSubview:img];
            [img mas_makeConstraints:^(MASConstraintMaker *make) {
                if (lastImg) {
                    if (i % 2 == 0) {
                        make.left.equalTo(self.doubleView);
                        make.top.equalTo(lastImg.mas_bottom).offset(cellPicInset);
                    } else {
                        make.left.equalTo(lastImg.mas_right).offset(cellPicInset);
                        make.top.equalTo(lastImg);
                    }
                } else {
                    make.left.top.equalTo(self.doubleView);
                }
                make.size.mas_equalTo(CGSizeMake(picW, picW));
            }];
            
            lastImg = img;
        }
    }
    return _doubleView;
}

- (UIView *)normalTypeView{
    
    if (!_normalTypeView) {
        _normalTypeView = [[UIView alloc] init];
        _normalTypeView.hidden = YES;
        
        UIImageView *lastImg = nil;
        CGFloat picW = 60;
        for (NSInteger i = 0; i < 9; i++) {
            
            UIImageView *img = [[UIImageView alloc] init];
            img.contentMode = UIViewContentModeScaleAspectFill;
            [_normalTypeView addSubview:img];
            [img mas_makeConstraints:^(MASConstraintMaker *make) {
                if (lastImg) {
                    if (i % 3 == 0) {
                        make.left.equalTo(self.normalTypeView);
                        make.top.equalTo(lastImg.mas_bottom).offset(cellPicInset);
                    } else {
                        make.left.equalTo(lastImg.mas_right).offset(cellPicInset);
                        make.top.equalTo(lastImg);
                    }
                } else {
                    make.left.top.equalTo(self.normalTypeView);
                }
                make.size.mas_equalTo(CGSizeMake(picW, picW));
            }];
            
            lastImg = img;
        }
    }
    return _normalTypeView;
}

@end
