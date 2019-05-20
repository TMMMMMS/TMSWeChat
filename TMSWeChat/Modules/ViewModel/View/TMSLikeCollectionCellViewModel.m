//
//  TMSLikeCollectionCellViewModel.m
//  TMSWeChat
//
//  Created by TmmmS on 2019/5/19.
//  Copyright © 2019年 TMS. All rights reserved.
//

#import "TMSLikeCollectionCellViewModel.h"
#import <NSAttributedString+YYText.h>

@interface TMSLikeCollectionCellViewModel ()
// 点赞的用户
@property (nonatomic, readwrite, copy) NSAttributedString *likeUserAttributedString;
@end

@implementation TMSLikeCollectionCellViewModel

@synthesize cellHeight = _cellHeight;

- (void)initializeConfig {

    [super initializeConfig];
    
    if (self.discoverModel.likes_num == 0) {
        return;
    }
    self.likeUserAttributedString = [self setupAttributedString];
}

- (void)calculateCellHeight {
    
    if (self.discoverModel.likes_num == 0) {
        _cellHeight = 0;
    } else {
        CGFloat leftPadding = cellPadding + 42 + cellItemInset * 3 + 12;
        YYTextLayout *layout = [YYTextLayout layoutWithContainerSize:CGSizeMake(SCREEN_WIDTH - leftPadding - cellPadding - cellItemInset, CGFLOAT_MAX) text:self.likeUserAttributedString];
        _cellHeight = 2*6 + layout.textBoundingSize.height;
    }
}

- (NSAttributedString *)setupAttributedString {
    
    NSArray *likeUserArray = [self.discoverModel.like_user componentsSeparatedByString:@"，"];
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:self.discoverModel.like_user];
    attr.yy_lineBreakMode = NSLineBreakByWordWrapping;
    attr.yy_color = [UIColor blackColor];
    for (NSInteger i = 0; i < likeUserArray.count; i++) {
        NSString *tempStr = likeUserArray[i];
        [attr yy_setTextHighlightRange:[self.discoverModel.like_user rangeOfString:tempStr]
                                color:RGB(88, 104, 144, 1)
                      backgroundColor:[UIColor colorWithWhite:0.000 alpha:0.220]
                            tapAction:^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect){
                                TLog(@"点击了:%@", [text.string substringWithRange:range]);
                            }];
        [attr yy_setFont:[UIFont systemFontOfSize:12 weight:UIFontWeightBold] range:[self.discoverModel.like_user rangeOfString:tempStr]];
    }
    
    return attr.copy;
}

@end
