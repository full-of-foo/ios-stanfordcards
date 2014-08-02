//
//  CardMatchingGame.m
//  stanfordcards
//
//  Created by Anthony Troy on 20/07/2014.
//  Copyright (c) 2014 dev. All rights reserved.
//

#import "CardMatchingGame.h"
#import "MatchingMode.h"

@interface CardMatchingGame()

- (void)matchTwo:(Card *)card;
- (void)matchThree:(Card *)card;

@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, strong) NSMutableArray *cards; // of Card
@property (nonatomic, readwrite) MatchingMode *mode;

@end


@implementation CardMatchingGame

- (NSMutableArray *)cards
{
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (instancetype)initWithCardCountAndMode:(NSUInteger)count
                               usingDeck:(Deck *)deck
                               usingMode:(MatchingMode *)mode
{
    self = [self initWithCardCount:count usingDeck:deck];
    self.mode = mode;
    
    return self;
}

- (instancetype)initWithCardCount:(NSUInteger)count
                        usingDeck:(Deck *)deck
{
    self = [super init];
    
    if (self) {
        for (int i = 0; i < count; i++) {
            Card *card = [deck drawRandomCard];
            if (card) {
                [self.cards addObject:card];
            } else {
                self = nil;
                break;
            }
        }
    }
    
    return self;
}

- (instancetype)init
{
    return nil;
}

- (void)matchTwo:(Card *)card
{
    for (Card *otherCard in self.cards) {
        
        if (otherCard.isChosen && !otherCard.isMatched) {
            int matchScore = [card match:@[otherCard]];
            
            if (matchScore) {
                self.score += matchScore * self.mode.matchBonus;
                card.matched = YES;
                otherCard.matched = YES;
            } else {
                self.score -= self.mode.mismatchPenalty;
                otherCard.chosen = NO;
            }
            break;
        }
    }
}

- (void)matchThree:(Card *)card
{
    NSMutableArray *selectedCards = [[NSMutableArray alloc] init];
    for (Card *otherCard in self.cards){
        if (otherCard.isChosen && !otherCard.isMatched) [selectedCards addObject:otherCard];
    }
    BOOL isLastSelection = ([selectedCards count] == (self.mode.cardAmount - 1));
    
    if (isLastSelection) {
        for (Card *selectedCard in selectedCards) {
            int matchScore = [card match:selectedCards];
            if (matchScore) {
                self.score += matchScore * self.mode.matchBonus;
                card.matched = YES;
                selectedCard.matched = YES;
            } else {
                self.score -= self.mode.mismatchPenalty;
                selectedCard.chosen = NO;
            }
        }
    }
}

- (void)choseCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    
    if (!card.isMatched) {
        if(card.isChosen){
            card.chosen = NO;
        } else {
            if (self.mode.cardAmount == 2) {
                [self matchTwo:card];
            } else if (self.mode.cardAmount == 3) {
                [self matchThree:card];
            }
            
            self.score -= self.mode.costToChoose;
            card.chosen = YES;
        }
    }
}

- (Card *)cardAtIndex:(NSUInteger)index
{
    return (index < [self.cards count]) ? self.cards[index] : nil;
}







@end
