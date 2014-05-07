//
//  loginViewController.m
//  proyectoComputacionUbicua
//
//  Created by Jose Luis Vizcaíno on 22/04/13.
//  Copyright (c) 2013 computaciónUbicua. All rights reserved.
//

#import "loginViewController.h"

@interface loginViewController ()

@end

@implementation loginViewController

@synthesize user, password, subjects, messages, loginButton;

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
    
    //*******************************
    //variables obligatorias
    //*******************************
    //inicializar el manejador de descargas
    
    descargar= [[ServicesManager alloc]init];
    parsear= [[JsonManager alloc]init];
    
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    tap.cancelsTouchesInView = NO;
    
    [self.view addGestureRecognizer:tap];
    
    textFieldUser.delegate = self;
    textFieldPass.delegate = self;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//Estos dos métodos son para que se esconda el teclado cuando pulsemos en la pantalla

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

-(void)dismissKeyboard {
    [textFieldUser resignFirstResponder];
    [textFieldPass resignFirstResponder];
}

//Estos dos métodos son para ajustar la pantalla al escribir en los editText

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    [UIView beginAnimations:@"" context:nil];
    CGRect f = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y-160, self.view.frame.size.width, self.view.frame.size.height);
    self.view.frame = f;
    [UIView commitAnimations];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [UIView beginAnimations:@"" context:nil];
    CGRect f = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y+160, self.view.frame.size.width, self.view.frame.size.height);
    self.view.frame = f;
    [UIView commitAnimations];
}

//método para iniciar la descarga no es obligatorio menos la llamada al hilo (para iniciar la accion)
//y la parte de usuario y contraseña para las peticiones al servidor

-(IBAction)descargar:(id)sender{
     self.terminado=true;
    
       //esto no te hace falta
    if (![textFieldUser.text isEqualToString:@""]&& ![textFieldPass.text isEqualToString:@""])
    {
        //***esto es importante***//
        [progressIndicator startAnimating];
        
        self.user=textFieldUser.text;
        self.password=textFieldPass.text;
        
        //****llamada al primer thread para descargar***//
        self.terminado=false;
        self.navegar=true;
        
       self.loginButton.enabled=NO;
        
        [[[NSThread alloc]initWithTarget:self selector:@selector(hiloSecundario) object:nil] start];
        
    }
    else
    {
    //tiene que introducir su usuario y contraseña
        self.navegar=false;
        self.alertStatus = [[UIAlertView alloc] initWithTitle:@"Error de login"
                                                        message:@"Introduce tu correo de la upm y tu contraseña para continuar"
                                                       delegate:[[UIApplication sharedApplication] delegate] cancelButtonTitle:nil otherButtonTitles:@"Vale", nil];
        [self.alertStatus show];
        
      

    }
    
    
        
    
}

//Para evitar un bucle infinito al logear

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    while (!self.terminado)
        [NSThread sleepForTimeInterval:0.1];
    
    return self.navegar;
}

//thread principal para tocar los elementos de la vista, no se pueden tocar desde hilos secundarios
-(void) hiloPrincipal{
    
    //Cuando se acaba de descargar se muestra en pantalla (en formato json)
    
    //navegar a siguiente si se ha descargado algo
   
    //[self.navigationController pushViewController:viewController animated:YES];
    //Parar el progresIndicator
    
    [progressIndicator stopAnimating];
   
    if([self.subjects isEqualToString:@""]){
        self.alertStatus = [[UIAlertView alloc] initWithTitle:@"Error al validar"
                                                      message:@"Por favor, revisa que tu correo y tu contraseña estén introducidos correctamente."
                                                     delegate:[[UIApplication sharedApplication] delegate] cancelButtonTitle:nil otherButtonTitles:@"Vale", nil];
        [self.alertStatus show];
        
        
    }
    else{
    //navegar a
        [self performSegueWithIdentifier:@"loggedin" sender:self]; 
    }
    
    self.loginButton.enabled = YES;

    
}


//thread intermedio donde irán las peticiones al servidor y se llamará a los métodos necesarios para parsear el json (si quieres eso)

-(void) hiloSecundario{
    //guardar los mensajes (string)
    self.messages=[ [descargar descargarMensajes :self.user segundo:self.password] stringByReplacingOccurrencesOfString:@"\n" withString:@""] ;
    
    //guardar las asignaturas (string)
    self.subjects=[ [descargar descargarAsignaturas:self.user segundo:self.password]
                      stringByReplacingOccurrencesOfString:@"\n" withString:@""] ;
    self.terminado=true;
    [descargar guardarAsignaturas:self.subjects];
    [descargar guardarMensajes:self.messages];
    
        //thread para tocar los elementos gráficos de la vista
    [self performSelectorOnMainThread:@selector(hiloPrincipal) withObject:nil waitUntilDone:NO];
    
}


@end
