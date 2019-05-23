//
//  TMSTimeCollectionCellViewModel.m
//  TMSWeChat
//
//  Created by TmmmS on 2019/5/19.
//  Copyright © 2019年 TMS. All rights reserved.
//

#import "TMSTimeCollectionCellViewModel.h"

@interface TMSTimeCollectionCellViewModel ()

@end

@implementation TMSTimeCollectionCellViewModel

@synthesize cellHeight = _cellHeight;

- (void)initializeConfig {
    
    [super initializeConfig];

}

- (void)calculateCellHeight {
    
    _cellHeight = 25;
}

@end
