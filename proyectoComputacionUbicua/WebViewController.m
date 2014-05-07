//
//  WebViewController.m
//  proyectoComputacionUbicua
//
//  Created by Ovidiu Moldovan on 23/05/13.
//  Copyright (c) 2013 computaciónUbicua. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()

@end


@implementation WebViewController

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
 //   [[webView alloc] init];
	// Do any additional setup after loading the view.
    NSString * urll=[[NSUserDefaults standardUserDefaults]  valueForKey:@"rowActivityLink"];
    NSURL* url = [NSURL URLWithString:urll];
    //URL Requst Object
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    
    //Load the request in the UIWebView.
    [webView loadRequest:requestObj];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    //Se recupera el número de la celda anteriormente pulsada
    }

@end
