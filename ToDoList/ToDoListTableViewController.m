
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

- (IBAction)unwindToList:(UIStoryboardSegue *)segue {
    
    //LAURA retrieve the source view controller you're unwinding from, AddToDoListController
    AddToDoItemViewController *source = [segue sourceViewController];
    
    //LAURA retrieve the value of hte controllers toDoItem property
    ToDoItem *item = source.toDoItem;
    
    //LAURA check to see if the item exists (hit the save button) if not (user hit the cancel button)
    if (item != nil){
        //LAURA add the new item to the array
        [self.toDoItems addObject:item];
        
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
