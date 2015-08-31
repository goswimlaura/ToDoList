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
    if (sender != self.saveButton) return;
    
    //LAURA check to see if user entered any text into the text field
    if (self.textField.text.length > 0){
    
        //LAURA if text create a new item and give it a name of the text in the textfield and enseure the completed state is set to NOfalse
        self.toDoItem = [[ToDoItem alloc] init];
        self.toDoItem.itemName = self.textField.text;
        self.toDoItem.completed = NO;
    }
}


@end
