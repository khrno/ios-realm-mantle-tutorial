//
//  ArticleListResponseModel.m
//  RealmMantleTutorial
//
//  Created by Pablo Ortega Mesa on 25-11-15.
//  Copyright © 2015 khrno.cl. All rights reserved.
//

#import "ArticleListResponseModel.h"

@implementation ArticleListResponseModel


#pragma mark -
#pragma mark Mantle
#pragma mark -
#pragma mark Mantle - JSONKeyPathsByPropertyKey
+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"articles": @"response.docs",
             @"status": @"status"
             };
}

#pragma mark Mantle - JSON Transformer
+ (NSValueTransformer *)articlesJSONTransformer
{
    return [MTLJSONAdapter arrayTransformerWithModelClass:ArticleModel.class];
}

@end
