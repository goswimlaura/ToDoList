
//
//  ToDoListTableViewController.m
//  ToDoList
//
//  Created by Laura Gordon on 8/27/15.
//  Copyright © 2015 Laura Gordon. All rights reserved.
//

#import "ToDoListTableViewController.h"
#import "ToDoItem.h" //LAURA tell class to see ToDoItem.h class that I created
#import "AddToDoItemViewController.h" //LAURA tell class to see AddToDoItemViewController

@interface ToDoListTableViewController ()

// I like that you have already started putting items in the private interface that
// are not meant to be seen by outside classes.
@property NSMutableArray *toDoItems;

@end

@implementation ToDoListTableViewController

// LAURA Create a new method loadInitialData. Create a few list items. and add them to the array
- (void)loadInitialData{
    ToDoItem *item1 = [[ToDoItem alloc] init];
    item1.itemName = @"Buy milk";
    [self.toDoItems addObject:item1];
    
    ToDoItem *item2 = [[ToDoItem alloc] init];
    item2.itemName = @"Buy eggs";
    [self.toDoItems addObject:item2];
    
    ToDoItem *item3 = [[ToDoItem alloc] init];
    item3.itemName = @"Read a book";
    [self.toDoItems addObject:item3];
    
}

- (IBAction)unwindToList:(UIStoryboardSegue *)segue
{
    
}

// this pragma statement places an entry in the dropdown list of methods
#pragma mark - AddToDoItemDelegate
// Normally I would place delegate methods at the end of the file
- (void) didFinishCreatingToDoItem:(AddToDoItemViewController *)controller item:(ToDoItem *)newItem
{
    // We can compare the controller passed in case we have more than one controller doing something, but we don't
    // so I will do nothing but an assert.
    // Sometimes you can be too agressive with asserts; you start adding them then find out that in some cases
    // it is valid to get nil (or whatever the assert it checking), but when you hit an Assert that you later determine
    // is not necessary, you tend to ensure that you check parameters and add error checking.
    NSParameterAssert(controller);
    
    // Do we really think that we will be called with a nil newItem - if we are then I would call that a bug in the controller
    // that called this method.
    NSParameterAssert(newItem);
    if (newItem != nil){
        //LAURA add the new item to the array
        [self.toDoItems addObject:newItem];

        //LAURA reload the data in your table
        [self.tableView reloadData];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //LAURA ADDED
    self.toDoItems = [[NSMutableArray alloc] init];
    //LAURA, call my new method loadInitialData
    [self loadInitialData];
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
- (IBAction)onAddToDoItem:(id)sender
{
    AddToDoItemViewController *newView = [self.storyboard instantiateViewControllerWithIdentifier:@"AddTodoItem"];
    NSAssert(newView != nil, @"Failed to create AddToDoItemViewController");
    // Navigation controllers are convenient, but there are other ways; this won't work correctly as is because
    // the AddToDoItemViewController expects to be pushed, just food for thought is all.
    // [self presentViewController:newView animated:YES completion:nil];
    
    // I have not really used storyboard, I read that you should just use "performSegueWithIdentifer", but again, you need
    // a way to create the controller so that you can add a delegate.  A better way is to figure out how to overide the init
    // in the new controller so you can pass the delegate in an init method....
    newView.delegate = self;
    [self.navigationController pushViewController:newView animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    //LAURA changed from 0 to 1
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //LAURA changed from 0 to number of items in the array
    return [self.toDoItems count];
}
  

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ListPrototypeCell" forIndexPath:indexPath];
    
    //LAURA CHanged red target in the line above
    //LAURA fetch the appropriate line in the toDoItems array and set the name of the item to the display in the cell.
    ToDoItem *toDoItem = [self.toDoItems objectAtIndex:indexPath.row];
    cell.textLabel.text = toDoItem.itemName;
    
    //Laura checks the completion state of a todo item and sets the cell accessory based on that.
    if (toDoItem.completed){
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }else{
        cell.accessoryType = UITableViewCellAccessoryNone;
    }

    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

//LAURA Toggles an item in the list as completed or not completed
#pragma mark - Table view delegate


- (void)tableview:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    //LAURA leave the cell unselected after it is tapped
    [tableView deselectRowAtIndexPath:indexPath  animated:NO];
    
    //LAURA search for the ToDoItem in toDoItems array that cooresponds to the cell that was tapped
    ToDoItem *tappedItem = [self.toDoItems objectAtIndex:indexPath.row];
    
    //LAURA toggle the completed state of the tapped item.
    tappedItem.completed = !tappedItem.completed;
    
    
    //LAURA tell the table view to reload the row whose data you just updated
    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    
}

@end
