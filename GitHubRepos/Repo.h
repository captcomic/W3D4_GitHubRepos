//
//  Repo.h
//  GitHubRepos
//
//  Created by Fariha on 6/21/18.
//  Copyright © 2018 Bootcamp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Repo : NSObject

@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *url;

- (instancetype)initWithAPIData:(NSDictionary*)data;

@end
