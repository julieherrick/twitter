//
//  Tweet.h
//  twitter
//
//  Created by Julie Herrick on 6/29/20.
//  Copyright © 2020 Emerson Malca. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

NS_ASSUME_NONNULL_BEGIN

@interface Tweet : NSObject

// MARK: Properties
@property (nonatomic, strong) NSString *idStr; // for favoriting, retweeting, and repling
@property (nonatomic, strong) NSString *text; // text content of tweet
@property (nonatomic) int favoriteCount; // update favorite count label
@property (nonatomic) BOOL favorited; // configure favorite button
@property (nonatomic) int retweetCount; // update retweet count label
@property (nonatomic) BOOL retweeted; // configure retweet button
@property (nonatomic, strong) User *user; //contains tweet author's name, screenname, etc.
@property (nonatomic, strong) NSString *createdAtString; // when tweet was created
@property (nonatomic, strong) NSDate *date; // date displayed

// For Retweets
@property (nonatomic, strong) User *retweetedByUser; //user who retweeted if twet is retweet


// MARK: Methods

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

+ (NSMutableArray *)tweetsWithArray:(NSArray *)dictionaries;

@end

NS_ASSUME_NONNULL_END
