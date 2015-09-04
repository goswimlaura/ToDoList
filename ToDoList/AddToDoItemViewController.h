//
//  AddToDoItemViewController.h
//  ToDoList
//
//  Created by Joseph Gordon on 8/27/15.
//  Copyright © 2015 Laura Gordon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ToDoItem.h"

@class AddToDoItemViewController;

@protocol AddToDoItemDelegate <NSObject>
// I am using @required - this tells the implementer they have to implement this method.  Also has the compiler complain if its not defined
// in the class that says its implelemting the delegate.
@required
/**
 *  didFinishCreatingToDoItem
 *
 *  @param controller the controller that is creating the ToDoItem
 *  @param newItem    The new ToDoItem that has been created.
 */
- (void) didFinishCreatingToDoItem:(AddToDoItemViewController *)controller item:(ToDoItem *)newItem;

@optional
// I don't have any optional methods, but often a Protocal can be wholly optional, or the other way, or mixed - depends on design
@end

@interface AddToDoItemViewController : UIViewController

// Its a better design to not have properties on a UIViewController that you need access to; sometimes it can be unavoidable, but with this
// it can be to much to worry about with respect when the controller goes away.  Now I see that you are using Storyboards which is fine;
// I work mostly with xib files which I find more flexible, they also make it easier to use dependencyInjection
// Also, while some say that having all the views in one storyboard lets you see how the app flows; well, perhaps the simplist app in the world,
// in practice I think it is a bad idea; I tend to have one xib (or storyboard) per viewController.  You may have more than one view created
// in that xib file, but one per controller.

// I have converted this to one alternate approach; another approach would be to use NSNotification and pass the newly created object
// in the userInfo dictionary which is an optional parameter...
// The way I have converted it to uses delegates;  One downside to delegates is that if you are going to need to have multiple objects
// care about the creation of ToDoItems then it can be messy.

//LAURA add a toDoItem property to the interface
//@property ToDoItem *toDoItem;

// Notice that I have traded one property for another, however the delegate leaks less implementation details.
// and if I were starting from scratch I would be passing in a protocol to an init method and there would be
// nothing in the header file.
@property (nonatomic, weak) id<AddToDoItemDelegate> delegate;

@end
