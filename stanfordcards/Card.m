//
//  Card.m
//  cardgame
//
//  Created by Anthony Troy on 19/07/2014.
//  Copyright (c) 2014 dev. All rights reserved.
//

#import "Card.h"

@interface Card()

@end

@implementation Card




- (int)match:(NSArray *)otherCards
{
    int score = 0;
    
    for (Card *card in otherCards) {
        if ([card.contents isEqualToString:self.contents]) {
            score = 1;
        }
    }
    
    return score;
}




@end