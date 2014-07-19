//
//  PlayingCard.h
//  cardgame
//
//  Created by Anthony Troy on 19/07/2014.
//  Copyright (c) 2014 dev. All rights reserved.
//

#import "Card.h"

@interface PlayingCard : Card

@property (strong, nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;

+ (NSArray *) rankStrings;
+ (NSUInteger) maxRank;
+ (NSArray *) validSuits;

@end
