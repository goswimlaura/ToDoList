//
//  AddToDoItemViewController.m
//  ToDoList
//
//  Created by Joseph Gordon on 8/27/15.
//  Copyright © 2015 Laura Gordon. All rights reserved.
//

#import "AddToDoItemViewController.h"


@interface AddToDoItemViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveButton;

@end

@implementation AddToDoItemViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    //LAURA if save button was not tapped, dont save the item, return without doing anything
    // return statements on the same line are bad :)  Verbose code is easier to read, and reading code is essential when you are
    // bug fixing and mainting; remember that 90% of the cost of a project is in maintenance.
    if (sender != self.saveButton) {
        return;
    }
    
    if ([self.textField.text length] == 0) {
        return;
    }
    
    // Because in Objective-C you can send an nil object a message, I don't check for nil, though if you want to be pedantic
    // you can; I usually do check for nil, but theres not much to gain here.  Because this call will only return true if the object
    // is non-nil and it does respond then we are good.  Now, remember that I specified that this method is required, so technically
    // you only need to check for nil then just make the call - I always check - just a habit
    if ([self.delegate respondsToSelector:@selector(didFinishCreatingToDoItem:item:)]) {
        // If you are using the default alloc init, new works the same
        ToDoItem *newItem = [ToDoItem new];
        // Did we check to see that textField.text has a value?
        newItem.itemName = self.textField.text;
        // I prefer what you have done by explicitly setting it, however if you know that an object
        // has many defaults, overide the init and set the defaults in the objet itself.
        newItem.completed = NO;
        // call the delegate.
        [self.delegate didFinishCreatingToDoItem:self item:newItem];
    }
    
}


@end
