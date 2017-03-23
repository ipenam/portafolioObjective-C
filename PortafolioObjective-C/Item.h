//
//  Item.h
//  PortafolioObjective-C
//
//  Created by Ivan Peña on 22/03/17.
//  Copyright © 2017 ipenam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Item : NSObject

+ (instancetype)randomItem;

- (instancetype)initWithItemName:(NSString *)name
                  valueInDollars:(int)value
                    serialNumber:(NSString *)sNumber;

@property (nonatomic, copy) NSString *itemName;
@property (nonatomic, copy) NSString *serialNumber;
@property (nonatomic) int valueInDollars;
@property (nonatomic, readonly, strong) NSDate *dateCreated;

@end
