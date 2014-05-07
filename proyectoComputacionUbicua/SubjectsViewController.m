//
//  SubjectsViewController.m
//  proyectoComputacionUbicua
//
//  Created by Jose Luis Vizcaíno on 11/05/13.
//  Copyright (c) 2013 computaciónUbicua. All rights reserved.
//

#import "SubjectsViewController.h"

#import "CustomSubjectCell.h"


@interface SubjectsViewController ()

@end

@implementation SubjectsViewController{
    NSMutableArray *mySubjects;
    NSMutableArray *myActivities;
    NSMutableArray *myCalendar;
}
//declarar el manejador de descargas

ServicesManager *descargar;

//declarar el parseador

JsonManager *parsear;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    descargar= [[ServicesManager alloc]init];
    parsear= [[JsonManager alloc]init];
    
    [self saveInSubjects];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Devuelve el número de secciones
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Devuelve el número de filas por sección
    return [mySubjects count];
}

//Para configurar la celda

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"Cell";
    CustomSubjectCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];

    // Configure the cell...
    Subject *subject = [mySubjects objectAtIndex:indexPath.row];
    cell.cellName.text = subject.name;
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
  //  [[NSUserDefaults standardUserDefaults] setInteger:indexPath.row forKey:@"rowNumber"];
    
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

//Para pasar el número de la celda a la siguiente vista

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"pasito"]){
        CustomSubjectCell *cell = (CustomSubjectCell*) sender;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
        
      [[NSUserDefaults standardUserDefaults] setInteger:indexPath.row forKey:@"rowNumber"];        

    }
}
-(void) saveInSubjects{
    
    //parsear y guardar en la property de asignaturas
    
    self.subjects = [descargar recuperarAsignaturas];
    
    mySubjects=[parsear parsearJsonAsignaturas:self.subjects];

}

@end
