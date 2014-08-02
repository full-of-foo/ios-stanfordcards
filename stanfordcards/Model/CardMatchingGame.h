//
//  CardMatchingGame.h
//  stanfordcards
//
//  Created by Anthony Troy on 20/07/2014.
//  Copyright (c) 2014 dev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"
#import "MatchingMode.h"

@interface CardMatchingGame : NSObject

// desingated initializer
- (instancetype)initWithCardCountAndMode:(NSUInteger)count
                               usingDeck:(Deck *)deck
                               usingMode:(MatchingMode *)mode;
- (void)choseCardAtIndex:(NSUInteger)index;
- (Card *)cardAtIndex:(NSUInteger)index;

@property (nonatomic, readonly) NSInteger score;
@property (nonatomic, readonly) MatchingMode *mode;

@end
