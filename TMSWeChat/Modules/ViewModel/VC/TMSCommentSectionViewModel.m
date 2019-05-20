//
//  TMSCommentSectionModel.m
//  TMSWeChat
//
//  Created by TmmmS on 2019/5/20.
//  Copyright © 2019年 TMS. All rights reserved.
//

#import "TMSCommentSectionViewModel.h"
#import "TMSCommentCollectionCellViewModel.h"
#import "TMSDiscoverModel.h"

@interface TMSCommentSectionViewModel ()
@property(nonatomic, strong) TMSDiscoverModel *discoverModel;
@property(nonatomic, readwrite, assign) NSInteger comment_num;
@property(nonatomic, readwrite, strong) NSArray <TMSCommentCollectionCellViewModel *>* viewModels;
@end

@implementation TMSCommentSectionViewModel

- (instancetype)initWithDiscoverModel:(TMSDiscoverModel *)model {
    
    if (self == [super init]) {
        self.discoverModel = model;
        
//        self.viewModel = [[TMSCommentCollectionCellViewModel alloc] initWithDiscoverModel:model];
        
        self.comment_num = model.comment_num;
        
        NSArray *itemArray = [model.comments.rac_sequence map:^TMSCommentCollectionCellViewModel *(TMSCommentModel *model) {
    
            TMSCommentCollectionCellViewModel *itemModel = [[TMSCommentCollectionCellViewModel alloc] initWithCommentModel:model];
            return itemModel;
        }].array;
        
        self.viewModels = itemArray;
    }
    return self;
}

- (nonnull id<NSObject>)diffIdentifier {
    return [NSString stringWithFormat:@"%zd", self.discoverModel.time];
}

- (BOOL)isEqualToDiffableObject:(nullable id<IGListDiffable>)object {
    
    if (object == self) {
        return YES;
    }
    TMSCommentSectionViewModel *obj = (TMSCommentSectionViewModel *)object;
    return [[NSString stringWithFormat:@"%zd", self.discoverModel.time] isEqualToString:[NSString stringWithFormat:@"%zd", obj.discoverModel.time]];
    
}

@end
