//
//  TMSDiscoverCollectionCell.m
//  TMSWeChat
//
//  Created by TmmmS on 2019/5/19.
//  Copyright © 2019年 TMS. All rights reserved.
//

#import "TMSDiscoverCollectionCell.h"

@implementation TMSDiscoverCollectionCell

+ (instancetype)createCellWithBaseCellViewModel:(TMSBaseCellViewModel *)baseCellViewModel {
    
    NSString *modelName = [NSString stringWithUTF8String:object_getClassName(baseCellViewModel)];
    NSString *cellName = [modelName stringByReplacingOccurrencesOfString:@"ViewModel" withString:@""];
    
    TMSDiscoverCollectionCell *cell = [[NSClassFromString(cellName) alloc] init];
    
    return cell;
}

- (void)bindViewModel:(id)viewModel {
    
}
@end
