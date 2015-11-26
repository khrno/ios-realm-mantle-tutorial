//
//  ArticleModel.h
//  RealmMantleTutorial
//
//  Created by Pablo Ortega Mesa on 25-11-15.
//  Copyright © 2015 khrno.cl. All rights reserved.
//

#import "MTLModel.h"
#import <Mantle/Mantle.h>

@interface ArticleModel : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy) NSString *leadParagraph;
@property (nonatomic, copy) NSString *url;

@end
