//
//  MatchingMode.m
//  stanfordcards
//
//  Created by Anthony Troy on 02/08/2014.
//  Copyright (c) 2014 dev. All rights reserved.
//

#import "MatchingMode.h"

@interface MatchingMode()

@property (nonatomic, readwrite) NSInteger cardAmount;
@property (nonatomic, readwrite) NSInteger mismatchPenalty;
@property (nonatomic, readwrite) NSInteger costToChoose;
@property (nonatomic, readwrite) NSInteger matchBonus;

@end

@implementation MatchingMode

- (instancetype)initWithCardAmount:(NSInteger)cardAmount
{
    self = [super init];
    
    if (self) {
        self.cardAmount = cardAmount;
        
        if (cardAmount == 2) {
            self.mismatchPenalty = 2;
            self.costToChoose = 1;
            self.matchBonus = 4;
        } else if (cardAmount == 3) {
            self.mismatchPenalty = 3;
            self.costToChoose = 1;
            self.matchBonus = 6;
        } else {
            self = nil;
        }
    }
    
    return self;
}

- (instancetype)init
{
    return nil;
}


@end
