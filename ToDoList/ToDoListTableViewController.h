//
//  ToDoListTableViewController.h
//  ToDoList
//
//  Created by Joseph Gordon on 8/27/15.
//  Copyright © 2015 Laura Gordon. All rights reserved.
//

#import <UIKit/UIKit.h>
// Because I have declared a delegate, I have to have the ToDoListTableViewController declare that we will implement the delegate.
#import "AddToDoItemViewController.h"

@interface ToDoListTableViewController : UITableViewController <AddToDoItemDelegate>

    - (IBAction)unwindToList:(UIStoryboardSegue *)segue;


@end
