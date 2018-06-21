//
//  Repo.m
//  GitHubRepos
//
//  Created by Fariha on 6/21/18.
//  Copyright © 2018 Bootcamp. All rights reserved.
//

#import "Repo.h"

@implementation Repo

- (instancetype)initWithAPIData:(NSDictionary *)dict
{
    if (self = [super init]) {
        _name = dict[@"name"];
        _url = dict[@"html_url"];
    }
    return self;
}

@end
