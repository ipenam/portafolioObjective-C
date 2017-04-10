//
//  CoursesTableViewController.m
//  PortafolioObjective-C
//
//  Created by Ivan Peña on 27/03/17.
//  Copyright © 2017 ipenam. All rights reserved.
//

#import "CoursesTableViewController.h"
#import "WebViewController.h"

@interface CoursesTableViewController () <NSURLSessionDataDelegate>

@property (nonatomic) NSURLSession *session;
@property (nonatomic, copy) NSArray *courses;

@end

@implementation CoursesTableViewController

- (instancetype)init
{
    // Call the superclass's designated initializer
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        
        UINavigationItem *navItem = self.navigationItem;
        navItem.title = @"Cursos";
        
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        _session = [NSURLSession sessionWithConfiguration:config
                                                 delegate:self
                                            delegateQueue:nil];
        [self fetchFeed];
    }
    return self;
}

- (instancetype)initWithStyle:(UITableViewStyle)style
{
    return [self init];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    [self.tableView registerClass:[UITableViewCell class]
           forCellReuseIdentifier:@"UITableViewCell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Fetch data

-(void)fetchFeed{
    
    //NSString *requestString = @"http://bookapi.bignerdranch.com/courses.json";
    NSString *requestString = @"https://bookapi.bignerdranch.com/private/courses.json";
    NSURL *url = [NSURL URLWithString:requestString];
    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    
    NSURLSessionDataTask *dataTask = [self.session dataTaskWithRequest:req
                                                 completionHandler:^(NSData *data, NSURLResponse *response, NSError *error){
                                                     NSString *json = [[NSString alloc] initWithData:data
                                                                                           encoding:NSUTF8StringEncoding];
                                                     
                                                     NSLog(@"%@", json);
                                                     
                                                     NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:data
                                                                                                                options:0
                                                                                                                  error:nil];
                                                     
                                                     NSLog(@"%@", jsonObject);
                                                     
                                                     self.courses = [jsonObject objectForKey:@"courses"];
                                                     
                                                     dispatch_async(dispatch_get_main_queue(), ^{
                                                         [self.tableView reloadData];
                                                     });
                                                 }];
    [dataTask resume];
    
}

-(void)URLSession:(NSURLSession *)session didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential * _Nullable))completionHandler{
    
    NSURLCredential *cred = [NSURLCredential credentialWithUser:@"BigNerdRanch"
                                                        password:@"AchieveNerdvana"
                                                     persistence:NSURLCredentialPersistenceForSession];
    completionHandler(NSURLSessionAuthChallengeUseCredential,cred);
}
    


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.courses count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    
    NSDictionary *course = [self.courses objectAtIndex:indexPath.row];
    cell.textLabel.text = [course objectForKey:@"title"];
    // Configure the cell...
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary *course = [self.courses objectAtIndex:indexPath.row];
    NSURL *URL = [NSURL URLWithString:[course objectForKey:@"url"]];
    
    self.webViewController.title = [course objectForKey:@"titel"];
    self.webViewController.URL = URL;
    
    [self.navigationController pushViewController:self.webViewController
                                         animated:YES];
}

@end
