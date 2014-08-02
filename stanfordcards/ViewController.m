//
//  ViewController.m
//  stanfordcards
//
//  Created by Anthony Troy on 20/07/2014.
//  Copyright (c) 2014 dev. All rights reserved.
//

#import "ViewController.h"
#import "Deck.h"
#import "PlayingCardDeck.h"
#import "PlayingCard.h"
#import "CardMatchingGame.h"
#import "MatchingMode.h"

@interface ViewController ()

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (strong, nonatomic) CardMatchingGame *game;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *modeSegment;
@property (weak, nonatomic) IBOutlet UITextView *notificationTextView;

@end


@implementation ViewController

- (Deck *)createDeck
{
    return [[PlayingCardDeck alloc] init];
}

- (MatchingMode *)createCurrentMatchingMode
{
    
    NSString *segmentTitle = [self.modeSegment titleForSegmentAtIndex:self.modeSegment.selectedSegmentIndex];
    int selectedMode = [[segmentTitle substringToIndex:1] intValue];
    
    return [[MatchingMode alloc] initWithCardAmount:selectedMode];
}

- (CardMatchingGame *)game
{
    int count = [self.cardButtons count];
    Deck *deck = [self createDeck];
    
    if (!_game) _game = [[CardMatchingGame alloc] initWithCardCountAndMode:count
                                                                 usingDeck:deck
                                                                 usingMode:[self createCurrentMatchingMode]];
    return _game;
}

- (void)resetGame
{
    self.game = nil;
    [self updateUI];
}


- (IBAction)touchCardButton:(UIButton *)sender
{
    int cardIndex = [self.cardButtons indexOfObject:sender];
    [self updateNotificationsTextView];
    [self.game choseCardAtIndex:cardIndex];
    
    [self updateUI];
    if (self.modeSegment.isEnabled) [self.modeSegment setEnabled:false];
}

- (IBAction)touchResetButton:(UIButton *)sender
{
    [self resetGame];
    [self.modeSegment setEnabled:true];
}

- (IBAction)touchCardModeSegment:(UISegmentedControl *)sender
{
    [self resetGame];
}

- (void)updateUI
{
    for (UIButton *cardButton in self.cardButtons) {
        int cardIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardIndex];
        
        [cardButton setTitle:[self titleForCard:card]
                    forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card]
                              forState:UIControlStateNormal];
        cardButton.enabled = !card.matched;
    }
    [self updateNotificationsTextView];
    
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
}

- (void) updateNotificationsTextView
{
    NSMutableString *notification = [[NSMutableString alloc] init];
    self.notificationTextView.text = self.game.status;
}

- (NSString *)titleForCard:(Card *)card
{
    return card.isChosen ? card.contents : @"";
}

- (UIImage *)backgroundImageForCard:(Card *)card
{
    return [UIImage imageNamed:card.isChosen ? @"CardFront" : @"CardRear"];
}

@end
