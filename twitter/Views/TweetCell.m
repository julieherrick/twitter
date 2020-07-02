//
//  TweetCell.m
//  twitter
//
//  Created by Julie Herrick on 6/30/20.
//  Copyright © 2020 Emerson Malca. All rights reserved.
//

#import "TweetCell.h"
#import "APIManager.h"
#import "UIImageView+AFNetworking.h"
#import "DateTools.h"

@implementation TweetCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (TweetCell*)loadTweet:(TweetCell *)cell tweet:(Tweet *)tweet {
    // setting properties
    cell.tweet = tweet;
    cell.nameLabel.text = tweet.user.name;
    cell.username.text = [@"@" stringByAppendingString:tweet.user.screenName];
    cell.tweetText.text = tweet.text;
    cell.dateLabel.text = tweet.date.shortTimeAgoSinceNow;
    
    if (tweet.user.profileUrl) {
        NSURL *url = [NSURL URLWithString:tweet.user.profileUrl];
        [cell.profileImage setImageWithURL:url];
    }
    
    cell.retweetLabel.text = [NSString stringWithFormat:@"%d", tweet.retweetCount];
    cell.favoriteLabel.text = [NSString stringWithFormat:@"%d", tweet.favoriteCount];
    
    if (tweet.favorited) {
        //red
        [cell.favoriteButton setImage:[UIImage imageNamed:@"favor-icon-red.png"] forState:UIControlStateNormal];
        cell.favoriteLabel.textColor = UIColor.redColor;
    } else {
        // gray
        [cell.favoriteButton setImage:[UIImage imageNamed:@"favor-icon.png"] forState:UIControlStateNormal];
        cell.favoriteLabel.textColor = UIColor.grayColor;
    }
    
    if (tweet.retweeted) {
        //red
        [cell.retweetButton setImage:[UIImage imageNamed:@"retweet-icon-green.png"] forState:UIControlStateNormal];
        cell.retweetLabel.textColor = UIColor.greenColor;
    } else {
        // gray
        [cell.retweetButton setImage:[UIImage imageNamed:@"retweet-icon.png"] forState:UIControlStateNormal];
        cell.retweetLabel.textColor = UIColor.grayColor;
    }
    
    return cell;
}

- (void)refreshData {
    // updates all of the views
    [self loadTweet:self tweet:self.tweet];
}

- (IBAction)didTapFavorite:(id)sender {
    // if tweet not favorited
    if (!self.tweet.favorited) {
        self.tweet.favorited = YES;
        self.tweet.favoriteCount += 1;
        
        [self refreshData];
        
        [[APIManager shared] favorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                 NSLog(@"Error favoriting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully favorited the following Tweet: %@", tweet.text);
            }
        }];
    } else {
        // unlike tweet
        NSLog(@"Tweet is already liked");
    }
}


- (IBAction)didTapRetweet:(id)sender {
    // if tweet not retweeted
    if (!self.tweet.retweeted) {
        self.tweet.retweeted = YES;
        self.tweet.retweetCount += 1;
        
        [self refreshData];
        
        [[APIManager shared] retweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                 NSLog(@"Error retweeting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully retweeted the following Tweet: %@", tweet.text);
            }
        }];
    } else {
        // unlike tweet
        NSLog(@"Tweet is already retweeted");
    }
}

@end
