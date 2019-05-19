//
//  TMSContentCellViewModel.m
//  TMSWeChat
//
//  Created by TmmmS on 2019/5/19.
//  Copyright © 2019年 TMS. All rights reserved.
//

#import "TMSContentCollectionCellViewModel.h"

@interface TMSContentCollectionCellViewModel ()
@property(nonatomic, readwrite, assign) CGFloat picHeight;
@end

@implementation TMSContentCollectionCellViewModel

@synthesize cellHeight = _cellHeight;

- (void)initializeConfig {
    
    [super initializeConfig];
    
    self.didClickedPicSubject = [RACSubject subject];
    self.didClickedNameSubject = [RACSubject subject];
}

- (void)calculateCellHeight {
    
    CGFloat cellHeight = cellItemInset; // TopMargin
    
    cellHeight += 42; // 头像高度
    
    CGFloat extraH = 15;
    
    // 文字高度
#warning 文字为空时计算高度仍有值，待检查原因
    CGFloat contentHeight = self.discoverModel.summary.length ? [self.discoverModel.summary boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 3*cellPadding - 42, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil].size.height : 0;
    
    // 图片高度
    CGFloat picH = 0;
    if (self.discoverModel.pic_num) {
        
        if (self.discoverModel.pic_num == 1) {
            picH= 180;
        } else if (self.discoverModel.pic_num == 2 || self.discoverModel.pic_num == 4) {
            
            NSInteger row = self.discoverModel.pic_num / 2;
            picH = row*90 + (row - 1) * cellPicInset;
            
        } else {
            NSInteger row = self.discoverModel.pic_num % 3 == 0 ? self.discoverModel.pic_num / 3 : (self.discoverModel.pic_num / 3 + 1);
            picH = row*60 + (row - 1) * cellPicInset;
        }
    }
    self.picHeight = picH;
    
    if (contentHeight == 0) {
        picH -= extraH;
    } else if (contentHeight <= extraH) { // 单行文字
        picH += 3;
        picH += cellItemInset;
    } else { // 多行文字
        picH += cellItemInset;
        picH += (contentHeight - extraH);
    }
    cellHeight += picH;
    
    _cellHeight = cellHeight;
}

@end
