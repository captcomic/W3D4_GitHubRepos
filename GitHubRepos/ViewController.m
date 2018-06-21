//
//  ViewController.m
//  GitHubRepos
//
//  Created by Fariha on 6/21/18.
//  Copyright © 2018 Bootcamp. All rights reserved.
//

#import "ViewController.h"
#import "Repo.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *repos;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //[self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
    
    self.repos = [[NSMutableArray alloc] init];
    
    NSURL *url = [NSURL URLWithString:@"https://api.github.com/users/captcomic/repos"]; // 1
    NSURLRequest *urlRequest = [[NSURLRequest alloc] initWithURL:url]; // 2
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration]; // 3
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration]; // 4
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error) { // 1
            // Handle the error
            NSLog(@"error: %@", error.localizedDescription);
            return;
        }
        
        NSError *jsonError = nil;
        //NSArray *repos = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError]; // 2
        NSArray *reposJSON = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        
        if (jsonError) { // 3
            // Handle the error
            NSLog(@"jsonError: %@", jsonError.localizedDescription);
            return;
        }
        
        // If we reach this point, we have successfully retrieved the JSON from the API
        //for (NSDictionary *repo in repos) { // 4
        for (NSDictionary *repo in reposJSON) { // 4
            NSString *repoName = repo[@"name"];
            NSLog(@"repo: %@", repoName);
            [self.repos addObject:[[Repo alloc] initWithAPIData:repo]];
        }
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            // This will run on the main queue
            [self.tableView reloadData];
        }];
 
    }]; // 5
    
    [dataTask resume]; // 6
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.repos.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class])];

    
    //NSDictionary *repo = self.repos[indexPath.row];
    //cell.textLabel.text = repo[@"name"];
    //cell.detailTextLabel.text = repo[@"html_url"];
    
    Repo *repo = self.repos[indexPath.row];
    cell.textLabel.text = repo.name;
    cell.detailTextLabel.text = repo.url;
    
    return cell;
    
    
}


@end
