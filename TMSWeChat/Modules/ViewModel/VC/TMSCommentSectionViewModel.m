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
@property(nonatomic, readwrite, assign) NSInteger comment_num;
@property(nonatomic, readwrite, strong) NSMutableArray <TMSCommentCollectionCellViewModel *>* viewModels;
@end

@implementation TMSCommentSectionViewModel

- (instancetype)initWithDiscoverModel:(TMSDiscoverModel *)model {
    
    if (self == [super init]) {
        self.discoverModel = model;
        self.viewModels = [NSMutableArray array];
        
//        self.viewModel = [[TMSCommentCollectionCellViewModel alloc] initWithDiscoverModel:model];
        
//        self.comment_num = model.comment_num;
        
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
//    NSMutableArray *tempArray = [NSMutableArray arrayWithArray:self.viewModels];
//    [tempArray addObject:itemModel];
    
//    TMSCommentSectionViewModel *sectionModel = [[TMSCommentSectionViewModel alloc] initWithDiscoverModel:self.discoverModel];
//    NSMutableArray *tempArray = [NSMutableArray arrayWithArray:sectionModel.viewModels];
//    [tempArray addObject:itemModel];
//    [sectionModel.viewModels removeLastObject];
//    [sectionModel.viewModels addObjectsFromArray:tempArray.copy];
    
//    self.comment_num++;
    
    [self.viewModels addObject:itemModel];
    
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"RefreshDatas" object:self];
    
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
