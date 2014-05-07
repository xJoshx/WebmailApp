//
//  remindersViewController.m
//  proyectoComputacionUbicua
//
//  Created by Jose Luis Vizcaíno on 03/06/13.
//  Copyright (c) 2013 computaciónUbicua. All rights reserved.
//

#import "RemindersViewController.h"

@interface RemindersViewController ()
    
@end

@implementation RemindersViewController

@synthesize Title, Content;

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
    
    /* Para controlar el teclado */
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    tap.cancelsTouchesInView = NO;
    
    [self.view addGestureRecognizer:tap];
    
    self.Title.delegate = self;
    self.Content.delegate = self;
    
    /*****/
    
	// Do any additional setup after loading the view.
    
    //ReminderList = [[NSMutableArray alloc]init];
}

//Para controlar que se reinicien los campos cuando se introduzca una nota
- (void)viewWillAppear:(BOOL)animated{
    NSString *title, *text = [[NSString alloc] init];
    title = self.Title.text;
    text = self.Content.text;
    
    //Si alguno de los campos está relleno, puedeq que el usuario sólo quiera comprobar algo en las notas antes de terminar, por eso es mejor no reiniciar los campos.
    
    if([title length] != 0 && [text length] != 0){
        self.Title.text = @"";
        self.Content.text = @"";
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//Guardar el contenido de los campos en un array y en memoria
- (IBAction)saveContent:(id)sender{

    NSMutableArray *titleArray = [[NSMutableArray alloc] init];
    NSMutableArray *contentArray = [[NSMutableArray alloc] init];
    
    NSString *title = [[NSString alloc]init];
    NSString *content = [[NSString alloc]init];
    
    title = self.Title.text;
    content = self.Content.text;

//Si no están los dos vacíos se procede
if([title length] != 0 && [content length] != 0){
        
    titleArray = [[[NSUserDefaults standardUserDefaults] objectForKey:@"_TitleArray"]mutableCopy];
    contentArray = [[[NSUserDefaults standardUserDefaults] objectForKey:@"_ContentArray"]mutableCopy];
    
    //Por si no hay nada en los nsuserdefaults, se vuelve a inicializar
    if([titleArray count] == 0){
        titleArray = [[NSMutableArray alloc]init];
        contentArray = [[NSMutableArray alloc]init];
        
        [titleArray addObject:title];
        [contentArray addObject:content];
        
        [[NSUserDefaults standardUserDefaults] setObject:titleArray forKey:@"_TitleArray"];
        [[NSUserDefaults standardUserDefaults] setObject:contentArray forKey:@"_ContentArray"];
    }
    
    else{
        [titleArray addObject:title];
        [contentArray addObject:content];
        
        [[NSUserDefaults standardUserDefaults] setObject:titleArray forKey:@"_TitleArray"];
        [[NSUserDefaults standardUserDefaults] setObject:contentArray forKey:@"_ContentArray"];
    }
}
}

//Para controlar que el teclado se oculte cuando no haga falta

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

-(void)dismissKeyboard {
    [Title resignFirstResponder];
    [Content resignFirstResponder];
}

//Ajustar la pantalla y el teclado

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    [UIView beginAnimations:@"" context:nil];
    CGRect f = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y-100, self.view.frame.size.width, self.view.frame.size.height);
    self.view.frame = f;
    [UIView commitAnimations];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [UIView beginAnimations:@"" context:nil];
    CGRect f = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y+100, self.view.frame.size.width, self.view.frame.size.height);
    self.view.frame = f;
    [UIView commitAnimations];
}

- (void)textViewDidBeginEditing:(UITextField *)textField {
    [UIView beginAnimations:@"" context:nil];
    CGRect f = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y-160, self.view.frame.size.width, self.view.frame.size.height);
    self.view.frame = f;
    [UIView commitAnimations];
}

- (void)textViewDidEndEditing:(UITextField *)textField {
    [UIView beginAnimations:@"" context:nil];
    CGRect f = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y+160, self.view.frame.size.width, self.view.frame.size.height);
    self.view.frame = f;
    [UIView commitAnimations];
}

@end
