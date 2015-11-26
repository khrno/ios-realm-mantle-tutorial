//
//  APIManager.m
//  RealmMantleTutorial
//
//  Created by Pablo Ortega Mesa on 25-11-15.
//  Copyright © 2015 khrno.cl. All rights reserved.
//

#import "APIManager.h"
#import "Mantle.h"

static NSString *const kArticlesListPath = @"/svc/search/v2/articlesearch.json";
static NSString *const kApiKey = @"a4e7f3cdcb341d86aded4c762541fc69:7:73593316";

@implementation APIManager

- (NSURLSessionDataTask *)getArticlesWithRequestModel:(ArticleListRequestModel *)requestModel
                                              success:(void (^)(ArticleListResponseModel *))success
                                              failure:(void (^)(NSError *))failure
{
    NSDictionary *parameters = [MTLJSONAdapter JSONDictionaryFromModel:requestModel error:nil];
    NSMutableDictionary *parametersWithKey = [[NSMutableDictionary alloc] initWithDictionary:parameters];
    [parametersWithKey setObject:kApiKey forKey:@"api-key"];
    
    return [self GET:kArticlesListPath
          parameters:parametersWithKey
             success:^(NSURLSessionDataTask *task, id responseObject){
                 NSDictionary *responseDictionary = (NSDictionary *)responseObject;
                 NSError *error;
                 ArticleListResponseModel *list = [MTLJSONAdapter modelOfClass:ArticleListResponseModel.class
                                                            fromJSONDictionary:responseDictionary
                                                                         error:&error];
                 success(list);
             }
             failure:^(NSURLSessionDataTask *task, NSError *error){
                 failure(error);
             }];
}

@end
