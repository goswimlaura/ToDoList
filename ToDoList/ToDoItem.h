//
//  ToDoItem.h
//  ToDoList
//
//  Created by Joseph Gordon on 8/28/15.
//  Copyright © 2015 Laura Gordon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ToDoItem : NSObject

@property NSString *itemName;
@property BOOL completed;
@property (readonly) NSDate *creationDate;

@end
