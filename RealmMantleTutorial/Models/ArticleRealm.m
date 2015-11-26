//
//  ArticleRealm.m
//  RealmMantleTutorial
//
//  Created by Pablo Ortega Mesa on 25-11-15.
//  Copyright © 2015 khrno.cl. All rights reserved.
//

#import "ArticleRealm.h"

@implementation ArticleRealm

- (id)initWithMantleModel:(ArticleModel *)articleModel
{
    self = [super init];
    if(!self) return nil;
    
    self.leadParagraph = articleModel.leadParagraph;
    self.url = articleModel.url;
    
    return self;
}

@end
