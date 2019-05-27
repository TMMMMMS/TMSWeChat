//
//  TMSInputView.m
//  TMSWeChat
//
//  Created by TmmmS on 2019/5/23.
//  Copyright © 2019年 TMS. All rights reserved.
//

#import "TMSInputView.h"
#import "TMSCommentCollectionCellViewModel.h"

static TMSInputView *_instance = nil;

@interface TMSInputView () <UITextFieldDelegate>
@property(nonatomic, strong) TMSCommentCollectionCellViewModel *viewModel;
@property(nonatomic, readwrite, strong) UITextField *textField;
@property(nonatomic, readwrite, strong) RACSubject *textFieldSubject;
@end

@implementation TMSInputView

- (instancetype)init {
    
    if (self == [super init]) {
        self.backgroundColor = [UIColor whiteColor];
        [self configViews];
        self.textFieldSubject = [RACSubject subject];
        
        [[[NSNotificationCenter defaultCenter] rac_addObserverForName:UIKeyboardWillHideNotification object:nil] subscribeNext:^(NSNotification * _Nullable x) {
            self.textField.text = nil;
            self.hidden = YES;
        }];
    }
    return self;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    if (self.textField.text.length == 0) {
        return NO;
    }
    [self.textFieldSubject sendNext:textField.text];
    [textField resignFirstResponder];
//    textField.text = nil;
    return YES;
}

- (void)bindViewModel:(TMSCommentCollectionCellViewModel *)viewModel {
    
    self.viewModel = viewModel;
}

- (void)configViews {
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = RGB(211, 211, 213, 1);
    [self addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self);
        make.height.equalTo(@0.5);
    }];
    
    self.textField = [[UITextField alloc] init];
    self.textField.borderStyle = UITextBorderStyleRoundedRect;
    self.textField.font = [UIFont systemFontOfSize:14];
    self.textField.returnKeyType = UIReturnKeyDone;
    self.textField.delegate = self;
    [self addSubview:self.textField];
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(@5);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 2*cellPadding, 25));
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
