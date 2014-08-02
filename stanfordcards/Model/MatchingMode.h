//
//  MatchingMode.h
//  stanfordcards
//
//  Created by Anthony Troy on 02/08/2014.
//  Copyright (c) 2014 dev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MatchingMode : NSObject

- (instancetype)initWithCardAmount:(NSInteger)cardAmount;

@property (nonatomic, readonly) NSInteger cardAmount;
@property (nonatomic, readonly) NSInteger mismatchPenalty;
@property (nonatomic, readonly) NSInteger matchBonus;
@property (nonatomic, readonly) NSInteger costToChoose;

@end
