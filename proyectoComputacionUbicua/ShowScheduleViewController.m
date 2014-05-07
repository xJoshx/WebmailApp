//
//  ShowScheduleViewController.m
//  proyectoComputacionUbicua
//
//  Created by Jose Luis Vizcaíno on 12/05/13.
//  Copyright (c) 2013 computaciónUbicua. All rights reserved.
//

#import "ShowScheduleViewController.h"

#import "CustomScheduleCell.h"

#import "Activity.h"
#import "Calendar.h"
#import "Subject.h"

#import "ServicesManager.h"
#import "JsonManager.h"

@interface ShowScheduleViewController (){
    NSMutableArray *mySubjects;
    NSMutableArray *myActivities;
    NSMutableArray *myCalendar;

}

@end

@implementation ShowScheduleViewController

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
    // 2 secciones: 0 para actividades y 1 para calendario
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // devuelve el número de elementos en el array correspondiente para asignarlo a las secciones
    int rowNumber;
    rowNumber = [[NSUserDefaults standardUserDefaults]integerForKey:@"rowNumber"];
    Subject *subject = [mySubjects objectAtIndex:rowNumber];
    
    switch (section) {
        case 0:
            NSLog(@"Activities: %d", [subject.getActivites count]);
            return [subject.getActivites count];
            break;
        case 1:
            NSLog(@"Calendar: %d", [subject.getCalendar count]);
            return [subject.getCalendar count];
            break;
    }
    //return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    //se recupera el número de la celda
    int rowNumber;
    rowNumber = [[NSUserDefaults standardUserDefaults]integerForKey:@"rowNumber"];
    
    static NSString *CellIdentifier = @"Cell";
    static NSString *CellIdentifier3 = @"Cell3";
    
    //dependiendo del tipo de contenido, se asignan los elementos 0 para actividades, 1 para calendarios
    
    if (indexPath.section == 0) {
        CustomScheduleCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        
        Subject *subject = [mySubjects objectAtIndex:rowNumber ];

        // Configure the cell...
        Activity *activity = [subject.getActivites objectAtIndex:indexPath.row];
        
        cell.cellName.text = activity.name;
        cell.cellLink.text = activity.link;
        
        return cell;
    }
    
    else if (indexPath.section == 1){
        CustomScheduleCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier3 forIndexPath:indexPath];
        
        Subject *subject = [mySubjects objectAtIndex:indexPath.row];
        
        // Configure the cell...
        Calendar *calendar = [subject.getCalendar objectAtIndex:rowNumber];
        
        //se asigna nombre y fecha
        cell.cellName.text = calendar.name;
        cell.cellDate.text = calendar.date;

        return cell;
    }
    return nil;
}

//Para poner el título en las secciones
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0)
        return @"Tareas";
    else
        return @"Calendario";
}

-(void) saveInSubjects{
    //parsear y guardar en la property de asignaturas
    
    self.subjects = [descargar recuperarAsignaturas];
    
    mySubjects=[parsear parsearJsonAsignaturas:self.subjects];

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

//Para pasar el número de la celda pulsada a la siguiente vista

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"actividadWeb"]){
        CustomScheduleCell *cell = (CustomScheduleCell*) sender;
        //se recupera el número de la celda
        int rowNumber;
        
        rowNumber = [[NSUserDefaults standardUserDefaults]integerForKey:@"rowNumber"];
                 
            Subject *subject = [mySubjects objectAtIndex:rowNumber ];
      
        NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
        
        int i = indexPath.row;
            // Configure the cell...
            Activity *activity = [subject.getActivites objectAtIndex: i ];
        
        [[NSUserDefaults standardUserDefaults] setValue:activity.link forKey:@"rowActivityLink"];
        
    }
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    /* NSURL *url = [NSURL URLWithString:@"http://www.stackoverflow.com"];
    
    if (![[UIApplication sharedApplication] openURL:url])
        
        NSLog(@"%@%@",@"Failed to open url:",[url description]);
    

    // Navigation logic may go here. Create and push another view controller.
   
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
