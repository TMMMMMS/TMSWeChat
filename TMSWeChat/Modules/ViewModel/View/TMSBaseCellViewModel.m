//
//  TMSBaseCellViewModel.m
//  TMSWeChat
//
//  Created by TmmmS on 2019/5/19.
//  Copyright © 2019年 TMS. All rights reserved.
//

#import "TMSBaseCellViewModel.h"

@interface TMSBaseCellViewModel ()
@property(nonatomic, readwrite, strong) TMSDiscoverModel *discoverModel;
@end

@implementation TMSBaseCellViewModel

- (void)initializeConfig {}

- (instancetype)initWithDiscoverModel:(TMSDiscoverModel *)model {
    
    if (self == [super init]) {
        self.discoverModel = model;
        [self initializeConfig];
        [self calculateCellHeight];
    }
    return self;
}

- (void)calculateCellHeight {
    
}

- (nonnull id<NSObject>)diffIdentifier {
    return self.discoverModel.ID;
}

- (BOOL)isEqualToDiffableObject:(nullable id<IGListDiffable>)object {
    
    if (object == self) {
        return YES;
    }
    TMSBaseCellViewModel *obj = (TMSBaseCellViewModel *)object;
    return [self.discoverModel.ID isEqualToString:obj.discoverModel.ID];
    
}

@end
