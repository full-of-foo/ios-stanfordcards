//
//  PlayingCard.m
//  cardgame
//
//  Created by Anthony Troy on 19/07/2014.
//  Copyright (c) 2014 dev. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard


- (int)match:(NSArray *)otherCards
{
    int score = 0;
    int otherCardAmount = [otherCards count];
    int matchAmount = 0;
    
    for(PlayingCard *otherCard in otherCards) {
        BOOL hasSuitMatch = ([self.suit isEqualToString:otherCard.suit]);
        BOOL hasRankMatch = (self.rank == otherCard.rank);
        
        if (hasSuitMatch || hasRankMatch) matchAmount++;
        
        if (hasSuitMatch) {
            score += 1;
        } else if (hasRankMatch) {
            score += 4;
        }
    }
    // do not score when all don't match
    if (matchAmount != otherCardAmount) score = 0;
    
    return score;
}

- (NSString *)contents
{
    
    return [[PlayingCard rankStrings][self.rank] stringByAppendingString:self.suit];
}


+ (NSArray *)rankStrings
{
    return @[@"?", @"A", @"2", @"3", @"4", @"5", @"6",
             @"7", @"8", @"9", @"10", @"J", @"Q", @"K"];
}

+ (NSUInteger)maxRank
{
    return [[PlayingCard rankStrings] count] - 1;
}

- (void)setRank:(NSUInteger)rank
{
    if (rank <= [PlayingCard maxRank]) {
        _rank = rank;
    }
}


@synthesize suit = _suit;

+ (NSArray *)validSuits
{
    return @[@"♠", @"♣", @"♦", @"♥"];
}

- (void)setSuit:(NSString *)suit
{
    if ([[PlayingCard validSuits] containsObject:suit]) {
        _suit = suit;
    }
}

- (NSString *)suit
{
    return _suit ? _suit : @"?";
}


@end
