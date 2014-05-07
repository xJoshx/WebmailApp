//
//  messagesViewController.m
//  proyectoComputacionUbicua
//
//  Created by Jose Luis Vizcaíno on 01/05/13.
//  Copyright (c) 2013 computaciónUbicua. All rights reserved.
//

#import "messagesViewController.h"

#import "CustomCell.h"

#import "Messages.h"
#import "ShowMessageViewController.h"

#import "ServicesManager.h"
#import "JsonManager.h"

@interface messagesViewController ()

@end

@implementation messagesViewController {
    NSMutableArray* myMessages;
}

//declarar el manejador de descargas

ServicesManager *descargar;

//declarar el parseador

JsonManager *parsear;

@synthesize messages;

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
    
    descargar= [[ServicesManager alloc]init];
    parsear= [[JsonManager alloc]init];
    
    [self saveInMessages];
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
    return [myMessages count];
}

//Editar las celdas

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    Messages *message = [myMessages objectAtIndex:indexPath.row];
    cell.cellName.text = message.Sender;
    cell.cellDate.text = message.Date;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //La altura de la celda
    return 100;
}

/*
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    cell.backgroundColor = cell.contentView.backgroundColor;
}
*/
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
   // [[NSUserDefaults standardUserDefaults] setInteger:indexPath.row forKey:@"rowNumberMessages"];
    
}

//Para guardar el número de la celda pulsada

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"paso"]){
        CustomCell *cell = (CustomCell*) sender;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
        
         [[NSUserDefaults standardUserDefaults] setInteger:indexPath.row forKey:@"rowNumberMessages"];
    }
}

- (void)saveInMessages{
    
    //parsear y guardar en la property de asignaturas
    
    self.messages = [descargar recuperarMensajes];
    
    myMessages = [parsear parsearJsonMensajes:self.messages];
    
}

@end
