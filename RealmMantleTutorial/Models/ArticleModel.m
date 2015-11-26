//
//  ArticleModel.m
//  RealmMantleTutorial
//
//  Created by Pablo Ortega Mesa on 25-11-15.
//  Copyright © 2015 khrno.cl. All rights reserved.
//

#import "ArticleModel.h"

@implementation ArticleModel

#pragma mark -
#pragma mark Mantle
#pragma mark -
#pragma mark Mantle - JSONKeyPathsByPropertyKey
+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"leadParagraph": @"lead_paragraph",
             @"url": @"web_url"
             };
}

@end
