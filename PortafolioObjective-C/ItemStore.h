//
//  ItemStore.h
//  PortafolioObjective-C
//
//  Created by Ivan Peña on 22/03/17.
//  Copyright © 2017 ipenam. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Item;

@interface ItemStore : NSObject

@property (nonatomic, readonly) NSArray *allItems;

+ (instancetype)sharedStore;
-(Item *)createItem;
-(void)removeItem:(Item *)item;
-(void)moveItemAtIndex:(NSUInteger)fromIndex
               toIndex:(NSUInteger)toIndex;

@end
