//
//  TMSCommentCollectionCellViewModel.m
//  TMSWeChat
//
//  Created by TmmmS on 2019/5/19.
//  Copyright © 2019年 TMS. All rights reserved.
//

#import "TMSCommentCollectionCellViewModel.h"
#import "TMSCommentModel.h"

@interface TMSCommentCollectionCellViewModel ()
@property(nonatomic, strong) TMSCommentModel *model;
@end

@implementation TMSCommentCollectionCellViewModel

@synthesize cellHeight = _cellHeight;

- (void)initializeConfig {
    
    [super initializeConfig];
    
}

- (instancetype)initWithCommentModel:(TMSCommentModel *)model {
    
    if (self == [super init]) {
        self.model = model;
        [self initializeConfig];
        [self calculateCellHeight];
    }
    return self;
}

- (void)calculateCellHeight {
    
    if (self.model.ID.length == 0) {
        _cellHeight = 0;
        return;
    }
    
    CGFloat topPadding = 5;
    CGFloat bottomPadding = 2.5;
    CGFloat leftPadding = cellPadding + 42 + cellItemInset * 2;
    YYTextLayout *layout = [YYTextLayout layoutWithContainerSize:CGSizeMake(SCREEN_WIDTH - leftPadding - cellPadding - cellItemInset, CGFLOAT_MAX) text:self.commentAttributedString];
    
    _cellHeight = layout.textBoundingSize.height + topPadding + bottomPadding;
}

- (NSAttributedString *)commentAttributedString {
    
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:self.model.showComment];
    attr.yy_lineBreakMode = NSLineBreakByCharWrapping;
    attr.yy_color = [UIColor blackColor];
    
    [attr yy_setTextHighlightRange:[self.model.showComment rangeOfString:self.model.from]
                             color:RGB(88, 104, 144, 1)
                   backgroundColor:[UIColor colorWithWhite:0.000 alpha:0.220]
                         tapAction:^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect){
                             TLog(@"点击了:%@", [text.string substringWithRange:range]);
                         }];
    [attr yy_setFont:[UIFont systemFontOfSize:12 weight:UIFontWeightBold] range:[self.model.showComment rangeOfString:self.model.from]];
    
    if (self.model.to) {
        [attr yy_setTextHighlightRange:[self.model.showComment rangeOfString:self.model.to]
                                 color:RGB(88, 104, 144, 1)
                       backgroundColor:[UIColor colorWithWhite:0.000 alpha:0.220]
                             tapAction:^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect){
                                 TLog(@"点击了:%@", [text.string substringWithRange:range]);
                             }];
        [attr yy_setFont:[UIFont systemFontOfSize:12 weight:UIFontWeightBold] range:[self.model.showComment rangeOfString:self.model.to]];
    }
    
    return attr;
}
@end
