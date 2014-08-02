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
- (NSArray *)selectedCards;

@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, strong) NSMutableArray *cards; // of Card
@property (nonatomic, readwrite) MatchingMode *mode;
@property (nonatomic, readwrite) NSMutableString *status;

@end


@implementation CardMatchingGame

- (NSMutableArray *)cards
{
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (NSMutableString *)status
{
    if (!_status) _status = [[NSMutableString alloc] init];
    return _status;
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
                int points = matchScore * self.mode.matchBonus;
                self.score += points;
                card.matched = YES;
                otherCard.matched = YES;
            } else {
                self.score -= self.mode.mismatchPenalty;
                otherCard.chosen = NO;
                [self.status setString:[NSString stringWithFormat:@"Lost %d points", self.mode.mismatchPenalty]];
            }
            break;
        }
    }
}

- (void)matchThree:(Card *)card
{
    BOOL isLastSelection = ([self.selectedCards count] == (self.mode.cardAmount - 1));
    
    if (isLastSelection) {
        for (Card *selectedCard in self.selectedCards) {
            int matchScore = [card match:self.selectedCards];
            if (matchScore) {
                int points = matchScore * self.mode.matchBonus;
                self.score += points;
                card.matched = YES;
                selectedCard.matched = YES;

            } else {
                self.score -= self.mode.mismatchPenalty;
                selectedCard.chosen = NO;
                [self.status setString:[NSString stringWithFormat:@"Lost %d points", self.mode.mismatchPenalty]];
            }
        }
    }
}

-(NSArray *)selectedCards
{
    NSMutableArray *selectedCards = [[NSMutableArray alloc] init];
    for (Card *otherCard in self.cards){
        if (otherCard.isChosen && !otherCard.isMatched) [selectedCards addObject:otherCard];
    }
    return selectedCards;
}


- (void)choseCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    BOOL isFirstSelection = ([self.selectedCards count] == 0);
    
    if (isFirstSelection) {
        [self setStatus:[NSMutableString stringWithFormat:@"Selected %@", card.contents]];
    } else {
        [self.status appendString:[NSString stringWithFormat:@", %@", card.contents]];
    }

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
