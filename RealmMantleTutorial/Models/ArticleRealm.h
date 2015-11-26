//
//  ArticleRealm.h
//  RealmMantleTutorial
//
//  Created by Pablo Ortega Mesa on 25-11-15.
//  Copyright © 2015 khrno.cl. All rights reserved.
//

#import "RLMObject.h"
#import "ArticleModel.h"

@interface ArticleRealm : RLMObject

@property NSString *leadParagraph;
@property NSString *url;

- (id)initWithMantleModel:(ArticleModel *)articleModel;

@end
