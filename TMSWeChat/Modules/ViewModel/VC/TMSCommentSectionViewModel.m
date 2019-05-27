//
//  TMSCommentSectionModel.m
//  TMSWeChat
//
//  Created by TmmmS on 2019/5/20.
//  Copyright © 2019年 TMS. All rights reserved.
//

#import "TMSCommentSectionViewModel.h"
#import "TMSCommentCollectionCellViewModel.h"

@interface TMSCommentSectionViewModel ()
@property(nonatomic, readwrite, strong) TMSDiscoverModel *discoverModel;
@property(nonatomic, readwrite, strong) NSMutableArray <TMSCommentCollectionCellViewModel *>* viewModels;
@end

@implementation TMSCommentSectionViewModel

- (instancetype)initWithDiscoverModel:(TMSDiscoverModel *)model {
    
    if (self == [super init]) {
        self.discoverModel = model;
        self.viewModels = [NSMutableArray array];
        
        NSArray *itemArray = [model.comments.rac_sequence map:^TMSCommentCollectionCellViewModel *(TMSCommentModel *model) {
    
            TMSCommentCollectionCellViewModel *itemModel = [[TMSCommentCollectionCellViewModel alloc] initWithCommentModel:model];
            return itemModel;
        }].array;
        
        [self.viewModels addObjectsFromArray:itemArray];
    }
    return self;
}

- (NSInteger)comment_num {
    
    return self.viewModels.count;
}

- (void)addCommentModel:(TMSCommentModel *)model {
    
    TMSCommentCollectionCellViewModel *itemModel = [[TMSCommentCollectionCellViewModel alloc] initWithCommentModel:model];
    
    [self.viewModels addObject:itemModel];
    
}

- (nonnull id<NSObject>)diffIdentifier {
    return self;
}

- (BOOL)isEqualToDiffableObject:(nullable id<IGListDiffable>)object {
    
    return [self isEqual:object];
    
}

@end
