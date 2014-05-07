//
//  ShowMessageViewController.m
//  proyectoComputacionUbicua
//
//  Created by Jose Luis Vizcaíno on 21/05/13.
//  Copyright (c) 2013 computaciónUbicua. All rights reserved.
//

#import "ShowMessageViewController.h"

#import "Messages.h"

#import "ServicesManager.h"
#import "JsonManager.h"

@interface ShowMessageViewController ()

@end

@implementation ShowMessageViewController{
    NSMutableArray* myMessages;
}

@synthesize name, text, date, messages;

//declarar el manejador de descargas
ServicesManager *descargar;
//declarar el parseador
JsonManager *parsear;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    //inicializamos constructores y guardamos
    descargar= [[ServicesManager alloc]init];
    parsear= [[JsonManager alloc]init];
    
    [self saveInMessages];
    
    //Se recupera el número de la celda anteriormente pulsada
    int rowNumberMessages;
    rowNumberMessages = [[NSUserDefaults standardUserDefaults]integerForKey:@"rowNumberMessages"];
    
    //se carga el mensaje
    Messages *message = [myMessages objectAtIndex:rowNumberMessages];
    
    //se ponen los elementos
    name.text = message.Sender;
    date.text = message.Date;
    text.text = message.Text;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)saveInMessages{
    
    //parsear y guardar en la property de asignaturas
    self.messages = [descargar recuperarMensajes];
    
    //if( asignaturas != nil)
    myMessages = [parsear parsearJsonMensajes:self.messages];

}

@end
