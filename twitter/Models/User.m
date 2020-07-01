//
//  User.m
//  twitter
//
//  Created by Julie Herrick on 6/29/20.
//  Copyright © 2020 Emerson Malca. All rights reserved.
//

#import "User.h"

@implementation User

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        self.name = dictionary[@"name"];
        self.screenName = dictionary[@"screen_name"];
        self.profileUrl = dictionary[@"profile_image_url_https"];
        // initialize other properties
    }
    return self;
}

@end
