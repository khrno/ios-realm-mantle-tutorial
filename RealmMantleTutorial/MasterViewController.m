//
//  MasterViewController.m
//  RealmMantleTutorial
//
//  Created by Pablo Ortega Mesa on 25-11-15.
//  Copyright © 2015 khrno.cl. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "APIManager.h"
#import "RLMRealm.h"
#import "RLMResults.h"
#import "ArticleRealm.h"


@interface MasterViewController ()

@property NSMutableArray *objects;
@property (nonatomic, strong) RLMResults *articles;
@end

@implementation MasterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;

    
    // Call to Endpoint api and save the article list in a persistent way with realm
    ArticleListRequestModel *requestModel = [ArticleListRequestModel new]; // (1)
    requestModel.query = @"Basketball";
    requestModel.articlesToDate = [[ArticleListRequestModel dateFormatter] dateFromString:@"20150706"];
    requestModel.articlesFromDate = [[ArticleListRequestModel dateFormatter] dateFromString:@"20150701"];
    
    [[APIManager sharedManager] getArticlesWithRequestModel:requestModel // (2)
                                                    success:^(ArticleListResponseModel *responseModel){
                                                        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{ //(3)
                                                            @autoreleasepool {
                                                                RLMRealm *realm = [RLMRealm defaultRealm];
                                                                [realm beginWriteTransaction];
                                                                [realm deleteAllObjects];
                                                                [realm commitWriteTransaction];
                                                                
                                                                [realm beginWriteTransaction];
                                                                for(ArticleModel *article in responseModel.articles){
                                                                    ArticleRealm *articleRealm = [[ArticleRealm alloc] initWithMantleModel:article]; //(4)
                                                                    [realm addObject:articleRealm];
                                                                }
                                                                [realm commitWriteTransaction];
                                                                
                                                                dispatch_async(dispatch_get_main_queue(), ^{ //(5)
                                                                    RLMRealm *realmMainThread = [RLMRealm defaultRealm]; // (6)
                                                                    RLMResults *articles = [ArticleRealm allObjectsInRealm:realmMainThread];
                                                                    self.articles = articles; //(7)
                                                                    [self.tableView reloadData];
                                                                    
                                                                });
                                                            }
                                                        });
                                                    }
                                                    failure:^(NSError *error) {
                                                        self.articles = [ArticleRealm allObjects];
                                                        [self.tableView reloadData];
                                                    }];
    
}

- (void)viewWillAppear:(BOOL)animated {
    self.clearsSelectionOnViewWillAppear = self.splitViewController.isCollapsed;
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    if ([[segue identifier] isEqualToString:@"showDetail"]) {
//        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
//        ArticleModel *article = self.articles[indexPath.row];
//        [[segue destinationViewController] setUrl:article.url];
//    }
    NSLog(@"Prepare for Segue");
}


#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.articles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    ArticleRealm *article = self.articles[[indexPath item]];
    cell.textLabel.text = article.leadParagraph;
    return cell;
//    NSDate *object = self.objects[indexPath.row];
//    cell.textLabel.text = [object description];
//    return cell;
}

@end
